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
          category = row.text.strip
          next
        end
        product = create_product(row, category)
        @price_table << { product: product, prices: create_prices(row), avg_price: avg_price(row) }
      end
      @price_table
    end

    def products
      @products ||= price_table.map { |row| row[:product] }
    end

    private

    def create_product(item, category)
      Product.new do |product|
        product.type = :agricultural
        product.category = category
        product.name = item.xpath('td[1]').text.strip
        product.quality = item.xpath('td[2]').text.strip
        product.presentation = Presentation.new(item.xpath('td[3]').text.strip)
        product.state = item.xpath('td[4]').text
      end
    end

    def create_prices(item)
      (5..9).map do |day|
        next if item.xpath("td[#{day}]").text == '-'
        {
          date: date(day),
          value: item.xpath("td[#{day}]").text.to_f
        }
      end.compact
    end

    def avg_price(item)
      item.xpath('td[10]').text.to_f
    end

    def date(day)
      day = table_header(day)&.split('/')&.first&.to_i
      Date.new(params[:Anio], params[:Mes], day)
    end
  end
end
