require "faraday"

module Tangany
  module Customers
    class Client
      attr_reader :adapter, :subscription, :version

      def initialize(adapter: Faraday.default_adapter, stubs: nil)
        @adapter = adapter
        @subscription = Tangany.subscription
        @version = Tangany.version

        @stubs = stubs
      end

      def connection
        @connection ||= Faraday.new do |faraday|
          faraday.adapter(adapter, @stubs)
          faraday.request(:json)
          faraday.response(:json, content_type: /\bjson$/, parser_options: {symbolize_names: true})
          faraday.url_prefix = Tangany.customers_base_url
        end
      end

      def customers
        CustomersResource.new(self)
      end

      def natural_persons
        NaturalPersonsResource.new(self)
      end

      def wallet_links
        WalletLinksResource.new(self)
      end
    end
  end
end
