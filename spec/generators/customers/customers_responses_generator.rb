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
        file = Dir.glob("#{root_folder}/retrieve/*.json").sort[0]
        FileUtils.cp(file, "spec/fixtures/responses/customers/customers/create/created.json")

        # conflicting
        customer_id = JSON.parse(File.read("spec/fixtures/bodies/customers/customers/create/valid_payload.json"))["id"]
        File.open("spec/fixtures/responses/customers/customers/create/conflicting.json", "w") do |file|
          file.write(JSON.pretty_generate({
            statusCode: 409,
            activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
            message: "Customer with ID \"#{customer_id}\" already exists.",
          }))
        end
      end

      def delete
        # cleanup
        cleanup("delete")

        # invalid customer
        File.open("#{root_folder}/delete/not_found.json", "w") do |file|
          file.write(JSON.pretty_generate(not_found_response))
        end
      end

      def list
        # cleanup
        cleanup("list")

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
        # cleanup
        cleanup("retrieve")

        # valid customers
        3.times do
          customer = FactoryBot.build(:customers_objects_customer)
          File.open("#{root_folder}/retrieve/#{customer.id}.json", "w") do |file|
            file.write(JSON.pretty_generate(JSON.parse(customer.to_json)))
          end
        end

        # invalid customer
        File.open("#{root_folder}/retrieve/not_found.json", "w") do |file|
          file.write(JSON.pretty_generate(not_found_response))
        end

        # deleted customer
        File.open("#{root_folder}/retrieve/deleted.json", "w") do |file|
          file.write(JSON.pretty_generate(deleted_response))
        end
      end

      def update
        # cleanup
        cleanup("update")

        # updated
        file = Dir.glob("#{root_folder}/retrieve/*.json").sort[0]
        FileUtils.cp(file, "spec/fixtures/responses/customers/customers/update/updated.json")

        # invalid customer
        File.open("#{root_folder}/update/not_found.json", "w") do |file|
          file.write(JSON.pretty_generate(not_found_response))
        end
      end

      private

      def cleanup(folder)
        Dir.glob("#{root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end

      def deleted_response
        {
          statusCode: 404,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Customer with ID \"deleted\" has been deleted",
        }
      end

      def not_found_response
        {
          statusCode: 404,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Customer with ID \"not_found\" was not found",
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
