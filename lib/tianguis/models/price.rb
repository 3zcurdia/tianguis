# frozen_string_literal: true

module Tianguis
  class Price
    attr_accessor :product, :unit, :cost_cent, :currency
    attr_reader :date

    def date=(value)
      @date = Date.parse(value)
    end

    def year
      date.year
    end

    def week
      date.cweek
    end
  end
end
