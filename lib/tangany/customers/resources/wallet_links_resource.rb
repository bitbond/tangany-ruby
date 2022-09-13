# frozen_string_literal: true

module Tangany
  module Customers
    class WalletLinksResource < Resource
      def list(**params)
        Collection.from_response(get_request("wallet-links", params: params), type: WalletLink)
      end
    end
  end
end
