# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersBodiesGenerator
      attr_reader :root_folder

      def initialize
        @root_folder = "spec/fixtures/bodies/customers/customers"
      end

      def create
        body = FactoryBot.build(:customers_bodies_customers_create)
        File.open("#{root_folder}/create/valid-payload.json", "w") do |file|
          file.write(JSON.pretty_generate(JSON.parse(body.to_json)))
        end
      end
    end
  end
end
