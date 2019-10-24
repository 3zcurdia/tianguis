# frozen_string_literal: true

module Tianguis
  class Market < BaseService
    def self.all
      new.list
    end

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
        state, name = row.text&.split(': ')
        {
          id: row.attributes['value']&.value&.to_i,
          state: state.strip,
          name: name.strip
        }
      end
    end
  end
end
