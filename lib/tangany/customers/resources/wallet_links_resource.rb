# frozen_string_literal: true

module Tangany
  module Customers
    class WalletLinksResource < Resource
      def create(**attributes)
        input = Tangany::Customers::WalletLinks::CreateInput.new(attributes)
        post_request("wallet-links", body: input.to_json)
      end

      def list(**params)
        Collection.from_response(get_request("wallet-links", params: params), type: WalletLink)
      end
    end
  end
end
