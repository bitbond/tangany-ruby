# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersResponsesGenerator
      attr_reader :root_folder

      def initialize
        @root_folder = "spec/fixtures/responses/customers/customers"
      end

      def create
        # created
        file = Dir.glob("#{root_folder}/retrieve/*.json").sort[0]
        FileUtils.cp(file, "spec/fixtures/responses/customers/customers/create/created.json")

        # conflicting
        customer_id = JSON.parse(File.read("spec/fixtures/bodies/customers/customers/create/valid-payload.json"))["id"]
        File.open("spec/fixtures/responses/customers/customers/create/conflicting.json", "w") do |file|
          file.write(JSON.pretty_generate({
            statusCode: 409,
            activityId: "e0303d0f-aa88-4b8a-b360-48a5580ebee1",
            message: "Customer with ID \"#{customer_id}\" already exists.",
          }))
        end
      end

      def delete
        # invalid customer
        File.open("#{root_folder}/delete/invalid.json", "w") do |file|
          file.write(JSON.pretty_generate(customer_not_found_response("invalid")))
        end
      end

      def list
        # empty
        File.open("#{root_folder}/list/empty.json", "w") do |file|
          file.write(JSON.pretty_generate(list_response_from_customer_ids([])))
        end

        # paginated
        customer_ids = Dir.glob("#{root_folder}/retrieve/*.json").map do |file|
          id = File.basename(file, ".json")
          next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

          id
        end.compact.sort
        File.open("#{root_folder}/list/paginated.json", "w") do |file|
          file.write(JSON.pretty_generate(list_response_from_customer_ids(customer_ids)))
        end
      end

      def retrieve
        # valid customers
        Dir.glob("#{root_folder}/retrieve/*.json").each { |file| File.delete(file) }
        3.times do
          customer = FactoryBot.build(:customers_objects_customer)
          File.open("#{root_folder}/retrieve/#{customer.id}.json", "w") do |file|
            file.write(JSON.pretty_generate(JSON.parse(customer.to_json)))
          end
        end

        # invalid customer
        File.open("#{root_folder}/retrieve/invalid.json", "w") do |file|
          file.write(JSON.pretty_generate(customer_not_found_response("invalid")))
        end
      end

      private

      def customer_not_found_response(customer_id)
        {
          statusCode: 404,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Customer with ID \"#{customer_id}\" was not found",
        }
      end

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
