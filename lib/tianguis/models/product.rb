# frozen_string_literal: true

module Tianguis
  class Product
    attr_accessor :type, :name, :state, :category
    attr_reader :quality, :variant

    def initialize
      yield(self) if block_given?
    end

    def to_h
      {
        type: type,
        name: name,
        quality: quality,
        variant: variant.to_h,
        state: state,
        category: category
      }
    end

    def quality=(value)
      @quality = parse_quality(value)
    end

    def variant=(value)
      @variant = Variant.new(value)
    end

    def parse_quality(value)
      case value.downcase
      when /primera/
        :first
      when /segunda/
        :second
      else
        :third
      end
    end
  end
end
