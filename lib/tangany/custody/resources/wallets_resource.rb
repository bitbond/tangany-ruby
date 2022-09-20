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

      def update(wallet_id, **params)
        safe_params = sanitize_params!(params)

        retrieve_response = get_request("wallet/#{wallet_id}")
        wallet = Wallet.new(retrieve_response.body)

        Wallet.new(patch_request(
          "wallet/#{wallet_id}",
          body: build_update_body_json(wallet.to_h, safe_params),
          headers: {"If-Match" => retrieve_response.headers["If-Match"]}
        ).body)
      end
    end
  end
end
