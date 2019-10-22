# frozen_string_literal: true

module Tianguis
  class Market
    attr_accessor :id, :name, :state

    def initialize
      yield(self) if block_given?
    end

    def to_h
      { id: id, name: name, state: state }
    end
  end
end
