module Tangany
  module Custody
    class Resource < Tangany::Resource
      def initialize(client, options = {})
        @protocol = Tangany.protocols.find { |protocol| protocol["asset_id"] == options[:asset_id] } if options[:asset_id]

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
        merge_protocol_header(headers) if @protocol
        headers
      end

      def merge_protocol_header(headers)
        header = @protocol["header"]
        headers.merge(header["name"] => header[Tangany.environment])
      end
    end
  end
end
