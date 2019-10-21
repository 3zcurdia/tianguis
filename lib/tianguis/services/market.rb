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
      opts = page.css('#ddlDestinoInfEsp option')
      opts.shift
      opts.map(&Market.method(:parse))
    end
  end
end
