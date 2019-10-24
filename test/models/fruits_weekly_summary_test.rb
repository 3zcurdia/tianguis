# frozen_string_literal: true

require 'test_helper'
require 'date'

module Tianguis
  class FruitsWeeklySummaryTest < Minitest::Test
    def service
      @service ||= FruitsWeeklySummary.new(year: 2019, month: 1, week: 1)
    end

    def test_parse_price_table_count
      VCR.use_cassette('fruits_weekly_summary_service') do
        assert_equal 71, service.price_table.count
      end
    end

    def test_parse_first_price_table_product
      VCR.use_cassette('fruits_weekly_summary_service') do
        product = service.price_table.first.product
        assert_equal 'Aguacate Hass', product[:name]
        assert_equal 'Michoacán', product[:state]
        assert_equal :first, product[:quality]
      end
    end

    def test_parse_last_price_table_product
      VCR.use_cassette('fruits_weekly_summary_service') do
        product = service.price_table.last.product
        assert_equal 'Chile Pasilla', product[:name]
        assert_equal 'Zacatecas', product[:state]
        assert_equal :first, product[:quality]
      end
    end

    def test_parse_first_price_table_prices
      VCR.use_cassette('fruits_weekly_summary_service') do
        prices = service.price_table.first.prices
        assert_equal(Date.new(2019, 1, 31), prices.first[:published_at])
        assert_equal([340_00, 320_00, 320_00, 320_00], prices.map { |x| x[:cost_cents] })
      end
    end

    def test_parse_last_price_table_prices
      VCR.use_cassette('fruits_weekly_summary_service') do
        prices = service.price_table.last.prices
        assert_equal(Date.new(2019, 1, 31), prices.first[:published_at])
        assert_equal([70_00, 70_00, 70_00, 70_00], prices.map { |x| x[:cost_cents] })
      end
    end
  end
end
