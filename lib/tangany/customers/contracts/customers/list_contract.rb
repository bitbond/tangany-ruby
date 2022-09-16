module Tangany
  module Customers
    module Customers
      class ListContract < Contract
        ALLOWED_ENVIRONMENTS = %w[production testing].freeze

        schema do
          config.validate_keys = true

          optional(:environment).filled(:string, included_in?: ALLOWED_ENVIRONMENTS)
          optional(:limit).filled(:integer, gt?: 0, lteq?: 500)
          optional(:sort).filled(:string, included_in?: ALLOWED_SORTS)
          optional(:start).filled(:integer, gt?: 0)
        end
      end
    end
  end
end
