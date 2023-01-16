module Tangany
  module Customers
    class Resource < Tangany::Resource
      private

      def default_headers
        {
          "tangany-subscription" => client.subscription,
          "tangany-version" => client.version
        }
      end
    end
  end
end
