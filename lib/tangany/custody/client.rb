require "faraday"

module Tangany
  module Custody
    class Client
      attr_reader :adapter, :client_id, :client_secret, :ecosystem, :subscription, :vault_url

      def initialize(adapter: Faraday.default_adapter, stubs: nil)
        @adapter = adapter
        @client_id = Tangany.client_id
        @client_secret = Tangany.client_secret
        @ecosystem = Tangany.ecosystem
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

      def wallets
        WalletsResource.new(self)
      end

      def wallet_statuses(asset_id:)
        WalletStatusesResource.new(self, asset_id: asset_id)
      end
    end
  end
end
