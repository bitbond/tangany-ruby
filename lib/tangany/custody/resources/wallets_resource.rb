module Tangany
  module Custody
    class WalletsResource < Resource
      def create(**params)
        Wallet.new(post_request("wallets", body: sanitize_params!(params).to_json).body)
      end

      def list(**params)
        Collection.from_response(get_request("wallets", params: sanitize_params!(params)), type: Wallet)
      end

      def retrieve(wallet)
        Wallet.new(get_request("wallet/#{wallet}").body)
      end
    end
  end
end
