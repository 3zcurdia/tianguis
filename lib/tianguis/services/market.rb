# frozen_string_literal: true

module Tianguis
  class MarketService < BaseService
    def path
      '/nuevo/Consultas/MercadosNacionales/PreciosDeMercado/Agricolas/ConsultaFrutasYHortalizas.aspx'
    end

    def list
      @list ||= fetch_list
    end

    private

    def fetch_list
      table = page.css('#ddlDestinoInfEsp option')
      table.shift
      table.map do |row|
        Market.new do |market|
          market.id = row.attributes['value']&.value&.to_i || -1
          market.state, market.name = row.text&.split(': ')
        end
      end
    end
  end
end
