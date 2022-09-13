# frozen_string_literal: true

module Tangany
  module Customers
    class WalletLinksResource < Resource
      def create(**attributes)
        contract = Tangany::Customers::WalletLinks::CreateContract.new(attributes)
        post_request("wallet-links", body: contract.to_json)
      end

      def list(**params)
        Collection.from_response(get_request("wallet-links", params: params), type: WalletLink)
      end
    end
  end
end
