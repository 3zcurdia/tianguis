# frozen_string_literal: true

module Tianguis
  module Parser
    class FruitsWeekly < ResultTable
      TableRow = Struct.new(:product, :prices, :avg_price)

      def initialize(**args)
        super
        @year = args[:year]
        @month = args[:month]
        @week = args[:week]
      end

      def price_table
        category = nil
        product = nil
        price_table = []
        table.each do |row|
          if row.css('.encabTIP2').any?
            category = row.text.strip.downcase
            next
          end
          product = if row.xpath('td[1]').text.strip == '-'
                      add_variant(row, product)
                    else
                      create_product(row, category)
                    end
          next unless product

          price_table << TableRow.new(product.to_h, create_prices(row), avg_price(row))
        end
        price_table
      end

      def products
        products ||= price_table.map { |row| row[:product] }
      end

      private

      attr_reader :year, :month, :week

      def create_product(row, kind)
        Product.new do |product|
          product.category = :agricultural
          product.kind = kind
          product.name = row.xpath('td[1]').text.strip
          product.quality = row.xpath('td[2]').text
          product.variant = row.xpath('td[3]').text
          product.state = row.xpath('td[4]').text.strip
        end
      end

      def add_variant(row, product)
        product.variant = row.xpath('td[3]').text
        product.state = row.xpath('td[4]').text.strip
        product
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
        day, month = table_header(day)&.split('/')
        month = months[month.downcase.to_sym]
        Date.new(current_year(month), month, day.to_i)
      end

      def current_year(current_month)
        if current_month == 12 && month == 1
          year - 1
        elsif current_month == 1 && month == 12
          year + 1
        else
          year
        end
      end

      def months
        @months ||= {
          ene: 1,
          feb: 2,
          mar: 3,
          abr: 4,
          may: 5,
          jun: 6,
          jul: 7,
          ago: 8,
          sep: 9,
          oct: 10,
          nov: 11,
          dic: 12
        }.freeze
      end
    end
  end
end
