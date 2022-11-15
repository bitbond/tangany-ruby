module Tangany
  module Customers
    class CustomersResource < Resource
      BASE_PATH = "customers"

      def create(**params)
        Customer.new(post_request(BASE_PATH, body: sanitize_params!(params).to_json).body)
      end

      def delete(customer_id)
        delete_request("#{BASE_PATH}/#{customer_id}")
      end

      def list(**params)
        Collection.from_response(get_request(BASE_PATH, params: sanitize_params!(params)), type: Customer)
      end

      def retrieve(customer_id)
        Customer.new(get_request("#{BASE_PATH}/#{customer_id}").body)
      end

      def update(customer_id, **params)
        Customer.new(put_request("#{BASE_PATH}/#{customer_id}", body: sanitize_params!(params).to_json).body)
      end
    end
  end
end
