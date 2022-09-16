module Tangany
  module Custody
    class Collection
      class << self
        def from_response(response, type:)
          body = response.body
          Tangany::Collection.new(
            data: body[:list].map { |attributes| type.new(attributes) },
            total: body.dig(:hits, :total),
            next_path: body.dig(:links, :next),
            previous_path: body.dig(:links, :previous)
          )
        end
      end
    end
  end
end
