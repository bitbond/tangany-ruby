module Tangany
  module Customers
    class NaturalPersonsResource < Resource
      BASE_PATH = "entities/natural-persons"
      def create(**params)
        NaturalPerson.new(post_request(BASE_PATH, body: sanitize_params!(params).to_json).body)
      end

      def delete(entity_id)
        delete_request("#{BASE_PATH}/#{entity_id}")
      end

      def list(**params)
        Collection.from_response(get_request(BASE_PATH, params: sanitize_params!(params)), type: NaturalPerson)
      end

      def retrieve(entity_id)
        NaturalPerson.new(get_request("#{BASE_PATH}/#{entity_id}").body)
      end

      def update(entity_id, **params)
        NaturalPerson.new(put_request("#{BASE_PATH}/#{entity_id}", body: sanitize_params!(params).to_json).body)
      end
    end
  end
end
