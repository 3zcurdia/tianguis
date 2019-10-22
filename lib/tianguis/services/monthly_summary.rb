# frozen_string_literal: true

module Tianguis
  class SummaryService < BaseService
    def initialize(year: Time.now.year, month: Time.now.month, market_id: 100)
      super(Anio: year, Mes: month, DestinoId: market_id)
    end

    def path
      '/nuevo/Consultas/MercadosNacionales/PreciosDeMercado/Agricolas/ResultadoConsultarMensualFrutasYHortalizas.aspx'
    end

    def price_table
      table = page.css('#tblResultados tr')
    end
  end
end
