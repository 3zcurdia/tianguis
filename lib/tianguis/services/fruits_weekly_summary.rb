# frozen_string_literal: true

module Tianguis
  class FruitsWeeklySummary < SummaryService
    def initialize(year: Time.now.year, month: Time.now.month, week: 1, market_id: 100)
      super(Anio: year, Mes: month, Semana: week, DestinoId: market_id)
    end

    def path
      '/nuevo/Consultas/MercadosNacionales/PreciosDeMercado/Agricolas/ResultadoConsultaSemanalFrutasYHortalizas.aspx'
    end

    def price_table
      return @price_table if defined?(@price_table)

      category = nil
      @price_table = []
      table.each do |row|
        if row.css('.encabTIP2').any?
          category = row.text.strip.downcase
          next
        end
        @price_table << TableRow.new(create_product(row, category), create_prices(row), avg_price(row))
      end
      @price_table
    end

    def products
      @products ||= price_table.map { |row| row[:product] }
    end

    private

    def create_product(item, category)
      Product.new do |product|
        product.category = :agricultural
        product.type = category
        product.name = item.xpath('td[1]').text.strip
        product.quality = item.xpath('td[2]').text
        product.variant = item.xpath('td[3]').text
        product.state = item.xpath('td[4]').text.strip
      end.to_h
    end

    def create_prices(item)
      (5..9).map do |day|
        price = item.xpath("td[#{day}]").text.to_f
        next if price.zero?

        {
          published_at: date(day),
          cost_cents: (price * 100).to_i,
          currency: 'MXN'
        }
      end.compact
    end

    def avg_price(item)
      {
        cost_cents: (item.xpath('td[10]').text.to_f * 100).to_i,
        currency: 'MXN',
        unit: :kg
      }
    end

    def date(day)
      day = table_header(day)&.split('/')&.first&.to_i
      Date.new(params[:Anio], params[:Mes], day)
    end
  end
end
