# frozen_string_literal: true

require "faraday"

module Tangany
  module Customers
    class Client
      attr_reader :subscription

      def initialize
        @subscription = Tangany.customers_subscription
      end

      def connection
        @connection ||= Faraday.new do |faraday|
          faraday.adapter(Faraday.default_adapter)
          faraday.request(:json)
          faraday.response(:json, content_type: /\bjson$/)
          faraday.url_prefix = Tangany.customers_base_url
        end
      end
    end
  end
end
