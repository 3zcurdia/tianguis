# frozen_string_literal: true

require 'test_helper'

module Tianguis
  class VariantTest < Minitest::Test
    def test_parse_raw_kg
      presentation = Tianguis::Variant.new('caja de 23 kg')
      assert_equal 23, presentation.quantity
      assert_equal :kg, presentation.unit
    end

    def test_parse_raw_pc
      presentation = Tianguis::Variant.new('caja de 23 piezas')
      assert_equal 23, presentation.quantity
      assert_equal :pc, presentation.unit
    end

    def test_parse_kg
      presentation = Tianguis::Variant.new('Kilogramo')
      assert_equal 1, presentation.quantity
      assert_equal :kg, presentation.unit
    end

    def test_parse_kg_humanized
      presentation = Tianguis::Variant.new('Por Kilogramo')
      assert_equal 1, presentation.quantity
      assert_equal :kg, presentation.unit
    end

    def test_parse_dozen
      presentation = Tianguis::Variant.new('Docena')
      assert_equal 12, presentation.quantity
      assert_equal :pc, presentation.unit
    end

    def test_parse_piece
      presentation = Tianguis::Variant.new('Pieza')
      assert_equal 1, presentation.quantity
      assert_equal :pc, presentation.unit
    end

    def test_parse_piece_humanized
      presentation = Tianguis::Variant.new('Por Pieza')
      assert_equal 1, presentation.quantity
      assert_equal :pc, presentation.unit
    end
  end
end
