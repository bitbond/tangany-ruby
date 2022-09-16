module Tangany
  module Customers
    class WalletLinksResource < Resource
      def create(**params)
        safe_params = Tangany::Customers::WalletLinks::CreateContract.new.to_safe_params!(params)
        post_request("wallet-links", body: safe_params.to_json)
      end

      def list(**params)
        Collection.from_response(get_request("wallet-links", params: params), type: WalletLink)
      end
    end
  end
end
