# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersResponsesGenerator
      attr_reader :root_folder

      def initialize
        @root_folder = "spec/fixtures/responses/customers/customers"
      end

      def create
        # cleanup
        cleanup("create")

        # created
        file = Dir.glob("#{root_folder}/retrieve/*.json").min
        FileUtils.cp(file, "spec/fixtures/responses/customers/customers/create/created.json")

        # conflicting
        customer_id = JSON.parse(File.read("spec/fixtures/inputs/customers/customers/create/valid_input.json"))["id"]
        File.write("spec/fixtures/responses/customers/customers/create/conflicting.json", JSON.pretty_generate({
          statusCode: 409,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Customer with ID \"#{customer_id}\" already exists."
        }))
      end

      def delete
        # cleanup
        cleanup("delete")

        # deleted
        customer_id = File.basename(Dir.glob("#{root_folder}/retrieve/*.json").min, ".json")
        File.write("#{root_folder}/delete/#{customer_id}.json", "{}")

        # invalid customer
        File.write("#{root_folder}/delete/not_found.json", JSON.pretty_generate(not_found_response))
      end

      def list
        # cleanup
        cleanup("list")

        # empty
        File.write("#{root_folder}/list/empty.json", JSON.pretty_generate(list_response_from_customer_ids([])))

        # paginated
        customer_ids = Dir.glob("#{root_folder}/retrieve/*.json").map do |file|
          id = File.basename(file, ".json")
          next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

          id
        end.compact.sort
        File.write("#{root_folder}/list/paginated.json", JSON.pretty_generate(list_response_from_customer_ids(customer_ids)))
      end

      def retrieve
        # cleanup
        cleanup("retrieve")

        # valid customers
        3.times do
          customer = FactoryBot.build(:customers_objects_customer)
          File.write("#{root_folder}/retrieve/#{customer.id}.json", JSON.pretty_generate(JSON.parse(customer.to_json)))
        end

        # invalid customer
        File.write("#{root_folder}/retrieve/not_found.json", JSON.pretty_generate(not_found_response))

        # deleted customer
        File.write("#{root_folder}/retrieve/deleted.json", JSON.pretty_generate(deleted_response))
      end

      def update
        # cleanup
        cleanup("update")

        # updated
        file = Dir.glob("#{root_folder}/retrieve/*.json").min
        FileUtils.cp(file, "spec/fixtures/responses/customers/customers/update/updated.json")

        # invalid customer
        File.write("#{root_folder}/update/not_found.json", JSON.pretty_generate(not_found_response))
      end

      private

      def cleanup(folder)
        Dir.glob("#{root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end

      def deleted_response
        {
          statusCode: 404,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Customer with ID \"deleted\" has been deleted"
        }
      end

      def not_found_response
        {
          statusCode: 404,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Customer with ID \"not_found\" was not found"
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
                self: "/customers/#{id}"
              }
            }
          end,
          _links: {
            next: customer_ids.present? ? "/customers?start=2&limit=1" : nil,
            previous: customer_ids.present? ? "/customers?start=0&limit=1" : nil
          }
        }
      end
    end
  end
end
