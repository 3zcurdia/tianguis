# frozen_string_literal: true

module Tianguis
  class SummaryService < BaseService
    TableRow = Struct.new(:product, :prices, :avg_price)
    def table_header(col)
      page.xpath("//*[@id='tblResultados']/tr[1]/td[#{col}]").children.first&.text
    end

    def table
      table = page.css('#tblResultados tr')
      table.shift
      table
    end
  end
end
