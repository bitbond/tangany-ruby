module Tangany
  module Custody
    class Resource < Tangany::Resource
      def initialize(client, options = {})
        @chain = Tangany.chains.find { |chain| chain["asset_id"] == options[:asset_id] } if options[:asset_id]

        super(client)
      end

      private

      def default_headers
        headers = {
          "tangany-client-id" => client.client_id,
          "tangany-client-secret" => client.client_secret,
          "tangany-subscription" => client.subscription,
          "tangany-vault-url" => client.vault_url
        }
        merge_chain_header(headers) if @chain
        headers
      end

      def merge_chain_header(headers)
        header = @chain["header"]
        headers.merge(header["name"] => header[Tangany.environment])
      end
    end
  end
end
