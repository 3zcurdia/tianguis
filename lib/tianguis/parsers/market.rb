# frozen_string_literal: true

module Tianguis
  module Parser
    class Market < Base
      def table
        table = page.css('#ddlDestinoInfEsp option')
        table.shift
        table
      end

      def list
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
end
