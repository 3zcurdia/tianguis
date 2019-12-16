# frozen_string_literal: true

module Tianguis
  module Parser
    class Base
      attr_reader :html

      def initialize(**args)
        @html = args[:html]
      end

      def page
        @page ||= Nokogiri::HTML(html)
      end
    end
  end
end
