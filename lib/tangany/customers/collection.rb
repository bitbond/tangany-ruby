module Tangany
  module Customers
    class Collection
      class << self
        def from_response(response, type:)
          body = response.body
          Tangany::Collection.new(
            data: body[:results].map { |attributes| type.new(attributes) },
            total: body[:total],
            next_path: body.dig(:_links, :next),
            previous_path: body.dig(:_links, :previous)
          )
        end
      end
    end
  end
end
