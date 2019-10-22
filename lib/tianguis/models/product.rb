# frozen_string_literal: true

module Tianguis
  class Product
    attr_accessor :type, :name, :quality, :presentation, :state, :category

    def initialize
      yield(self) if block_given?
    end

    def to_h
      {
        type: type,
        name: name,
        quality: quality,
        presentation: presentation.to_h,
        state: state,
        category: category
      }
    end
  end
end
