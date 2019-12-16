# frozen_string_literal: true

module Tianguis
  class Market < BaseService
    def self.all
      new.list
    end

    def path
      '/nuevo/Consultas/MercadosNacionales/PreciosDeMercado/Agricolas/ConsultaFrutasYHortalizas.aspx'
    end

    def parser
      @parser ||= Parser::Market.new(html: body)
    end

    def list
      @list ||= parser.list
    end
  end
end
