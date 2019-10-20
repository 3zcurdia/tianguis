# frozen_string_literal: true

require 'test_helper'

module Tianguis
  class PresentationTest < Minitest::Test
    def test_parse_raw
      presentation = Tianguis::Presentation.new('caja de 23 kg')
      assert_equal 23, presentation.quantity
      assert_equal :kg, presentation.unit
    end

    def test_parse_raw
      presentation = Tianguis::Presentation.new('caja de 23 piezas')
      assert_equal 23, presentation.quantity
      assert_equal :pc, presentation.unit
    end

    def test_parse_kg
      presentation = Tianguis::Presentation.new('Kilogramo')
      assert_equal 1, presentation.quantity
      assert_equal :kg, presentation.unit
    end

    def test_parse_kg_humanized
      presentation = Tianguis::Presentation.new('Por Kilogramo')
      assert_equal 1, presentation.quantity
      assert_equal :kg, presentation.unit
    end

    def test_parse_dozen
      presentation = Tianguis::Presentation.new('Docena')
      assert_equal 12, presentation.quantity
      assert_equal :pc, presentation.unit
    end

    def test_parse_piece
      presentation = Tianguis::Presentation.new('Pieza')
      assert_equal 1, presentation.quantity
      assert_equal :pc, presentation.unit
    end

    def test_parse_piece_humanized
      presentation = Tianguis::Presentation.new('Por Pieza')
      assert_equal 1, presentation.quantity
      assert_equal :pc, presentation.unit
    end
  end
end
