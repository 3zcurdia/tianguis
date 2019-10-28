# frozen_string_literal: true

module Tianguis
  class Variant
    attr_reader :name, :quantity, :unit

    def initialize(name)
      @name = name.strip.sub('.', '')
      @quantity, @unit = parse(name)
    end

    def to_h
      { name: name, quantity: quantity, unit: unit }
    end

    private

    def parse(value)
      case value.downcase
      when /.*\s+de\s+(\d+)\skg/
        [Regexp.last_match(1).to_i, :kg]
      when /.*\s+de\s+(\d+)\s.*/
        [Regexp.last_match(1).to_i, :pc]
      when /tonelada/
        [1000, :kg]
      when /kilogramo/
        [1, :kg]
      when /ciento/
        [100, :pc]
      when /docena/
        [12, :pc]
      else
        [1, :pc]
      end
    end
  end
end
