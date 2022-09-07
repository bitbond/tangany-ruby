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

      def update(customer_id:, **attributes)
        response = get_request("customers/#{customer_id}")

        customer_hash = Customer.new(response.body).to_h
        update_body_hash = Tangany::Customers::Customers::UpdateBody.new(attributes).to_h

        Customer.new(patch_request(
          "customers/#{customer_id}",
          body: build_body(customer_hash, update_body_hash),
          headers: { "If-Match" => response.headers["If-Match"] }
        ).body)
      end

      private

      def build_body(customer_hash, update_body_hash)
        merged_hash = customer_hash.deep_merge(update_body_hash)
        hash_diff = HashDiff::Comparison.new(merged_hash, customer_hash)
        hash_diff.to_operations_json
      end
    end
  end
end
