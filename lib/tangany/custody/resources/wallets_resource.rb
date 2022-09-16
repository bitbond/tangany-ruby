module Tangany
  module Custody
    class WalletsResource < Resource
      def list(**params)
        safe_params = Wallets::ListContract.new.to_safe_params!(params)
        Collection.from_response(get_request("wallets", params: safe_params), type: Wallet)
      end
    end
  end
end
