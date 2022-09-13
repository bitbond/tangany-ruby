# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersResource < Resource
      def create(**attributes)
        contract = Tangany::Customers::Customers::CreateContract.new.call!(attributes)
        Customer.new(post_request("customers", body: contract.to_h.to_json).body)
      end

      def delete(customer_id)
        delete_request("customers/#{customer_id}")
      end

      def list(**params)
        Collection.from_response(get_request("customers", params: params), type: Customer)
      end

      def retrieve(customer_id)
        Customer.new(get_request("customers/#{customer_id}").body)
      end

      def update(**attributes)
        response = get_request("customers/#{attributes[:id]}")

        customer_hash = Customer.new(response.body).to_h
        update_contract_hash = Tangany::Customers::Customers::UpdateContract.new.call!(attributes).to_h

        Customer.new(patch_request(
          "customers/#{attributes[:id]}",
          body: build_update_body_json(customer_hash, update_contract_hash),
          headers: {"If-Match" => response.headers["If-Match"]}
        ).body)
      end

      private

      def build_update_body_json(customer_hash, update_contract_hash)
        merged_hash = customer_hash.deep_merge(update_contract_hash)
        hash_diff = HashDiff::Comparison.new(merged_hash, customer_hash)
        hash_diff.to_operations_json
      end
    end
  end
end
