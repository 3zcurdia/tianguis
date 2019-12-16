# frozen_string_literal: true

module Tianguis
  class BaseService
    attr_reader :params
    BASE_URL = 'http://www.economia-sniim.gob.mx'

    def initialize(**args)
      @params = args.compact
    end

    def conn
      @conn ||= Faraday.new(url: BASE_URL)
    end

    def request
      conn.get(path, params)
    end

    def url
      BASE_URL + path
    end

    def body
      @body ||= request.body
    end

    def parser
      raise 'Parser has not been implemented'
    end

    def path
      raise 'Path has not been implemented'
    end
  end
end
