# frozen_string_literal: true

module Tangany
  module Customers
    module Customers
      class UpdateBody < Dry::Struct
        attribute :operations, Types::Array.of(Operation)

        def to_json
          operations.map(&:to_h).to_json
        end
      end
    end
  end
end
