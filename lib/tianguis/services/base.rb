# frozen_string_literal: true

module Tianguis
  class BaseService
    BASE_URL = 'http://www.economia-sniim.gob.mx'

    def initialize(**params)
      @conn = Faraday.new(url: BASE_URL)
      @params = params
    end

    def get(options = {})
      conn.get(path, params.merge(options))
    end

    def page
      @page ||= Nokogiri::HTML(get.body)
    end

    def path
      raise 'Path has not beed implemented'
    end

    private

    attr_reader :conn, :params
  end
end
