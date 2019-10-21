# frozen_string_literal: true

module Tianguis
  class Market
    attr_accessor :name, :code, :state

    def self.parse(item)
      new do |market|
        market.code = item.attributes['value']&.value&.to_i || -1
        market.state, market.name = item.text&.split(': ')
      end
    end

    def initialize
      yield(self) if block_given?
    end

    def to_h
      { code: code, name: name, state: state }
    end
  end
end
