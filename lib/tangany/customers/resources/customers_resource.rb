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
        if_match_header = get_request("customers/#{customer_id}").headers["If-Match"]
        body = Tangany::Customers::Customers::UpdateBody.new(operations: operations)
        Customer.new(patch_request(
          "customers/#{customer_id}",
          body: body,
          headers: { "If-Match" => if_match_header }
        ).body)
      end
    end
  end
end
