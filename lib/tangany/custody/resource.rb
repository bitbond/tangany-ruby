module Tangany
  module Custody
    class Resource < Tangany::Resource
      private

      def default_headers
        {
          "tangany-client-id" => client.client_id,
          "tangany-client-secret" => client.client_secret,
          "tangany-subscription" => client.subscription,
          "tangany-vault-url" => client.vault_url
        }
      end
    end
  end
end
