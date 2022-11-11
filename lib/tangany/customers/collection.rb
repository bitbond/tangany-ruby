module Tangany
  module Customers
    class Collection
      class << self
        def from_response(response, type:)
          body = response.body
          Tangany::Collection.new(
            data: body[:items].map { |attributes| type.new(attributes) },
            total: body.dig(:pageInfo, :totalResults),
            next_page_token: body[:nextPageToken]
          )
        end
      end
    end
  end
end
