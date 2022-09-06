# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersResource < Resource
      def create(**attributes)
        body = Tangany::Customers::Customers::CreateBody.new(attributes)
        Customer.new(post_request("customers", body: body).body)
      end

      def delete(customer_id:)
        delete_request("customers/#{customer_id}")
      end

      def list(**params)
        Collection.from_response(get_request("customers", params: params), type: Customer)
      end

      def retrieve(customer_id:)
        Customer.new(get_request("customers/#{customer_id}").body)
      end

      def update(customer_id:, operations: [])
        body = Tangany::Customers::Customers::UpdateBody.new(operations: operations)
        Customer.new(patch_request("customers/#{customer_id}", body: body).body)
      end
    end
  end
end
