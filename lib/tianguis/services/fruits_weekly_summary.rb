# frozen_string_literal: true

module Tianguis
  class FruitsWeeklySummary < BaseService
    def initialize(year: Time.now.year, month: 10, week: 1, market_id: 100)
      super(Anio: year, Mes: month, Semana: week, DestinoId: market_id)
    end

    def path
      '/nuevo/Consultas/MercadosNacionales/PreciosDeMercado/Agricolas/ResultadoConsultaSemanalFrutasYHortalizas.aspx'
    end

    def parser
      @parser ||= Parser::FruitsWeekly.new(html: body, year: params[:Anio], month: params[:Mes], week: params[:Semana])
    end

    def price_table
      @price_table ||= parser.price_table
    end

    def products
      parser.products
    end
  end
end
