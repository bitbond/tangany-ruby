module Tangany
  module Customers
    class WalletLinksResource < Resource
      def create(**params)
        post_request("wallet-links", body: sanitize_params!(params).to_json)
      end

      def list(**params)
        Collection.from_response(get_request("wallet-links", params: params), type: WalletLink)
      end
    end
  end
end
