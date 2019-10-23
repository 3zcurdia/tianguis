# frozen_string_literal: true

module Tianguis
  class Summary
    def self.build(**args)
      FruitsWeeklySummary.new(args)
    end
  end
end
