module Tangany
  module Customers
    class WalletLinksResource < Resource
      def create(**params)
        WalletLink.new(post_request("wallet-links", body: sanitize_params!(params).to_json).body)
      end

      def list(**params)
        Collection.from_response(get_request("wallet-links", params: sanitize_params!(params)), type: WalletLink)
      end

      def retrieve(wallet_link_id)
        WalletLink.new(get_request("wallet-links/#{wallet_link_id}").body)
      end
    end
  end
end
