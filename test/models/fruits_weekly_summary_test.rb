# frozen_string_literal: true

require 'test_helper'
require 'date'

module Tianguis
  class FruitsWeeklySummaryTest < Minitest::Test
    def service
      @service ||= FruitsWeeklySummary.new(year: 2019, month: 1, week: 1)
    end

    def test_parse_price_table_product
      VCR.use_cassette("fruits_weekly_summary_service") do
        assert_equal 71, service.price_table.count
        assert_equal 'Aguacate Hass', service.price_table.first[:product].name
        assert_equal 'Michoacán', service.price_table.first[:product].state

        assert_equal 'Chile Pasilla', service.price_table.last[:product].name
        assert_equal 'Zacatecas', service.price_table.last[:product].state
      end
    end

    def test_parse_price_table_prices
      VCR.use_cassette("fruits_weekly_summary_service") do
        assert_equal Date.new(2019,1,31), service.price_table.first[:prices].first[:date]
        assert_equal [340.0, 0.0, 320.0, 320.0, 320.0], service.price_table.first[:prices].map { |x| x[:value] }
        assert_equal [70.0, 0.0, 70.0, 70.0, 70.0], service.price_table.last[:prices].map { |x| x[:value] }
      end
    end
  end
end
