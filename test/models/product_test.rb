# frozen_string_literal: true

require 'test_helper'

module Tianguis
  class ProductTest < Minitest::Test
    def test_quality_parse_first
      product = Tianguis::Product.new
      product.quality = 'primera'
      assert_equal 1, product.quality
    end

    def test_quality_parse_second
      product = Tianguis::Product.new
      product.quality = 'segunda'
      assert_equal 2, product.quality
    end

    def test_quality_parse_third
      product = Tianguis::Product.new
      product.quality = 'tercera'
      assert_equal 3, product.quality
    end

    def test_quality_parse_unkown
      product = Tianguis::Product.new
      product.quality = 'desconocida'
      assert_equal 0, product.quality
    end

    def test_variant_parse
      product = Tianguis::Product.new
      product.variant = 'caja de 9 kg'
      variant = product.variant
      assert_equal 9, variant.quantity
      assert_equal :kg, variant.unit
    end
  end
end
