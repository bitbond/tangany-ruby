module Tangany
  module Customers
    class CustomersResource < Resource
      def create(**params)
        Customer.new(post_request("customers", body: sanitize_params!(params).to_json).body)
      end

      def delete(customer_id)
        delete_request("customers/#{customer_id}")
      end

      def list(**params)
        Collection.from_response(get_request("customers", params: sanitize_params!(params)), type: Customer)
      end

      def retrieve(customer_id)
        Customer.new(get_request("customers/#{customer_id}").body)
      end

      def update(**params)
        safe_params = sanitize_params!(params)
        customer_id = safe_params[:id]

        retrieve_response = get_request("customers/#{customer_id}")
        customer = Customer.new(retrieve_response.body)

        Customer.new(patch_request(
          "customers/#{customer_id}",
          body: build_update_body_json(customer.to_h, safe_params),
          headers: {"If-Match" => retrieve_response.headers["If-Match"]}
        ).body)
      end

      private

      def build_update_body_json(customer_hash, safe_params)
        merged_hash = customer_hash.deep_merge(safe_params)
        hash_diff = HashDiff::Comparison.new(merged_hash, customer_hash)
        hash_diff.to_operations_json
      end
    end
  end
end
