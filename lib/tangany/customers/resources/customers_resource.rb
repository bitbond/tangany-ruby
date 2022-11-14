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

      def update(customer_id, **params)
        Customer.new(put_request("customers/#{customer_id}", body: sanitize_params!(params).to_json).body)
      end
    end
  end
end
