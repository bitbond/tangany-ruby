# frozen_string_literal: true

module Tangany
  class Config
    attr_accessor :customers_subscription

    attr_reader :customers_base_url
    attr_reader :customers_version

    def initialize
      @customers_base_url = "https://api.tangany.com/customers"
      @customers_version = "1"
    end
  end
end
