module Tangany
  module Customers
    class WalletLinksResource < Resource
      BASE_PATH = "wallet-links"

      def create(**params)
        WalletLink.new(post_request(BASE_PATH, body: sanitize_params!(params).to_json).body)
      end

      def delete(wallet_link_id)
        delete_request("#{BASE_PATH}/#{wallet_link_id}")
      end

      def list(**params)
        Collection.from_response(get_request(BASE_PATH, params: sanitize_params!(params)), type: WalletLink)
      end

      def retrieve(wallet_link_id)
        WalletLink.new(get_request("#{BASE_PATH}/#{wallet_link_id}").body)
      end
    end
  end
end
