# frozen_string_literal: true

module Tianguis
  class Product
    attr_accessor :name, :state, :category, :kind
    attr_reader :quality, :variant

    def initialize
      yield(self) if block_given?
    end

    def to_h
      {
        name: name,
        quality: quality,
        variant: variant.to_h,
        state: state,
        category: category,
        kind: kind
      }
    end

    def quality=(value)
      @quality = calc_quality(value)
    end

    def variant=(value)
      @variant = Variant.new(value)
    end

    def calc_quality(value)
      case value.downcase
      when /primera/
        1
      when /segunda/
        2
      when /tercera/
        3
      else
        0
      end
    end
  end
end
