module Tangany
  module Custody
    class WalletsResource < Resource
      def list(**params)
        Collection.from_response(get_request("wallets", params: params), type: Wallet)
      end
    end
  end
end
