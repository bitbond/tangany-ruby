require "faraday"

module Tangany
  module Custody
    class Client
      attr_reader :adapter, :client_id, :client_secret, :subscription, :vault_url

      def initialize(adapter: Faraday.default_adapter, stubs: nil)
        @adapter = adapter
        @client_id = Tangany.client_id
        @client_secret = Tangany.client_secret
        @subscription = Tangany.subscription
        @vault_url = Tangany.vault_url

        @stubs = stubs
      end

      def connection
        @connection ||= Faraday.new do |faraday|
          faraday.adapter(adapter, @stubs)
          faraday.request(:json)
          faraday.response(:json, content_type: /\bjson$/, parser_options: {symbolize_names: true})
          faraday.url_prefix = Tangany.custody_base_url
        end
      end
    end
  end
end
