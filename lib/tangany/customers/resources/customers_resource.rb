# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersResource < Resource
      def list(**params)
        Collection.from_response(get_request("customers", params: params), type: Customer)
      end
    end
  end
end
