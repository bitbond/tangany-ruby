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

      # TODO: list_documents

      def retrieve(customer_id)
        Customer.new(get_request("customers/#{customer_id}").body)
      end

      def update(customer_id, **params)
        safe_params = sanitize_params!(params)

        retrieve_response = get_request("customers/#{customer_id}")
        customer = Customer.new(retrieve_response.body)

        Customer.new(patch_request(
          "customers/#{customer_id}",
          body: build_update_body_json(customer.to_h, safe_params),
          headers: {"If-Match" => retrieve_response.headers["If-Match"]}
        ).body)
      end

      # TODO: upload_document
    end
  end
end
