# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersGenerator
      attr_reader :root_folder

      def initialize
        @root_folder = "spec/fixtures/responses/customers/customers"
      end

      def list
        File.open("#{root_folder}/list/empty.json", "w") do |file|
          file.write(JSON.pretty_generate(list_response_from_customer_ids([])))
        end

        customer_ids = Dir.glob("#{root_folder}/retrieve/*.json").map { |file| File.basename(file, ".json") }.sort
        File.open("#{root_folder}/list/paginated.json", "w") do |file|
          file.write(JSON.pretty_generate(list_response_from_customer_ids(customer_ids)))
        end
      end

      def retrieve
        Dir.glob("#{root_folder}/retrieve/*.json").each { |file| File.delete(file) }
        3.times do
          customer = FactoryBot.build(:customers_customer)
          File.open("#{root_folder}/retrieve/#{customer.id}.json", "w") do |file|
            file.write(JSON.pretty_generate(JSON.parse(customer.to_json)))
          end
        end
      end

      private

      def list_response_from_customer_ids(customer_ids)
        {
          total: customer_ids.size,
          results: (customer_ids[1..1] || []).map do |id|
            {
              id: id,
              environment: "testing",
              _links: {
                self: "/customers/#{id}",
              },
            }
          end,
          _links: {
            next: customer_ids.present? ? "/customers?start=2&limit=1" : nil,
            previous: customer_ids.present? ? "/customers?start=0&limit=1" : nil,
          },
        }
      end
    end
  end
end
