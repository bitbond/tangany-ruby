# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersResource < Resource
      def list(**params)
        Collection.from_response(get_request("customers", params: params), type: Customer)
      end

      def retrieve(customer_id:)
        Customer.new(get_request("customers/#{customer_id}").body)
      end
    end
  end
end
