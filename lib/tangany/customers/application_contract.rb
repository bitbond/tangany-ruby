module Tangany
  module Customers
    class ApplicationContract < Tangany::ApplicationContract
      ALLOWED_ENVIRONMENTS = %w[production testing].freeze
    end
  end
end
