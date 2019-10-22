# frozen_string_literal: true

module Tianguis
  class Presentation
    attr_reader :value, :quantity, :unit
    def initialize(value)
      @value = value
      @quantity, @unit = parse(value)
    end

    def to_h
      { quantity: quantity, unit: unit }
    end

    private

    def parse(value)
      case value.downcase
      when /.*\s+de\s+(\d+)\skg/
        [Regexp.last_match(1).to_i, :kg]
      when /.*\s+de\s+(\d+)\s.*/
        [Regexp.last_match(1).to_i, :pc]
      when /kilogramo/
        [1, :kg]
      when /docena/
        [12, :pc]
      else
        [1, :pc]
      end
    end
  end
end
