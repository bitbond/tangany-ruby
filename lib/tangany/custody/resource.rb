module Tangany
  module Custody
    class Resource < Tangany::Resource
      def initialize(client, options = {})
        @network = Tangany.networks.fetch(options[:asset_id]) if options[:asset_id]

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
        merge_network_header(headers) if @network
        headers
      end

      def merge_network_header(headers)
        header = @network["header"]
        headers.merge(header["name"] => header[Tangany.ecosystem])
      end
    end
  end
end
