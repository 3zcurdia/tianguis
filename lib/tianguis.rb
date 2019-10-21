# frozen_string_literal: true

require 'date'
require 'faraday'
require 'nokogiri'
require 'tianguis/version'
require 'tianguis/models/market'
require 'tianguis/models/presentation'
require 'tianguis/models/product'
require 'tianguis/models/price'
require 'tianguis/services/base'
require 'tianguis/services/market'

module Tianguis
  class Error < StandardError; end
  # Your code goes here...
end
