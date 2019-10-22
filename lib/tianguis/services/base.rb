# frozen_string_literal: true

module Tianguis
  class BaseService
    attr_reader :conn, :params
    BASE_URL = 'http://www.economia-sniim.gob.mx'

    def initialize(**args)
      @conn   = Faraday.new(url: BASE_URL)
      @params = args.compact
    end

    def request
      conn.get(path, params)
    end

    def page
      @page ||= Nokogiri::HTML(request.body)
    end

    def path
      raise 'Path has not beed implemented'
    end
  end
end
