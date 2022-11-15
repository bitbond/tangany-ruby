require "fileutils"

module Tangany
  module Customers
    class NaturalPersonsResponsesGenerator
      attr_reader :inputs_root_folder, :responses_root_folder

      def initialize
        @inputs_root_folder = "spec/fixtures/generated/inputs/customers/natural_persons"
        @responses_root_folder = "spec/fixtures/generated/responses/customers/natural_persons"
      end

      def create
        # cleanup
        cleanup("create")

        # created
        file = fetch_natural_person_file_name
        FileUtils.cp(file, "#{responses_root_folder}/create/created.json")

        # conflicting
        File.write("#{responses_root_folder}/create/conflicting.json", JSON.pretty_generate({
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Entity with given ID already exists.",
          statusCode: 409
        }))
      end

      def delete
        # cleanup
        cleanup("delete")

        # deleted
        customer_id = File.basename(fetch_natural_person_file_name, ".json")
        File.write("#{responses_root_folder}/delete/#{customer_id}.json", "{}")

        # invalid customer
        File.write("#{responses_root_folder}/delete/not_found.json", JSON.pretty_generate(not_found_response))
      end

      def list
        # cleanup
        cleanup("list")

        # empty
        File.write("#{responses_root_folder}/list/empty.json", JSON.pretty_generate(list_response_from_natural_persons([])))

        # paginated
        natural_persons = Dir.glob("#{responses_root_folder}/retrieve/*.json").map do |file|
          next unless File.basename(file, ".json").match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

          JSON.parse(File.read(file))
        end.compact.sort_by { |a| a["id"] }
        File.write("#{responses_root_folder}/list/paginated.json", JSON.pretty_generate(list_response_from_natural_persons(natural_persons)))
      end

      def retrieve
        # cleanup
        cleanup("retrieve")

        # valid natural_persons
        3.times do
          natural_person = FactoryBot.build(:customers_objects_natural_person)
          File.write("#{responses_root_folder}/retrieve/#{natural_person.id}.json", JSON.pretty_generate(JSON.parse(natural_person.to_json)))
        end

        # invalid natural_person
        File.write("#{responses_root_folder}/retrieve/not_found.json", JSON.pretty_generate(not_found_response))
      end

      def update
        # cleanup
        cleanup("update")

        # updated
        file = fetch_natural_person_file_name
        FileUtils.cp(file, "#{responses_root_folder}/update/updated.json")

        # invalid customer
        File.write("#{responses_root_folder}/update/not_found.json", JSON.pretty_generate(not_found_response))
      end

      private

      def cleanup(folder)
        FileUtils.mkdir_p("#{responses_root_folder}/#{folder}")
        Dir.glob("#{responses_root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end

      def fetch_natural_person_file_name
        Dir.glob("#{responses_root_folder}/retrieve/*.json").map do |file|
          id = File.basename(file, ".json")
          next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

          file
        end.compact.min
      end

      def not_found_response
        {
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Resource not found",
          statusCode: 404
        }
      end

      def list_response_from_natural_persons(natural_persons)
        {
          nextPageToken: (natural_persons.size > 1) ? "foo" : nil,
          pageInfo: {
            totalResults: natural_persons.size,
            resultsPerPage: 100
          },
          items: (natural_persons[1..1] || []).map.to_a
        }
      end
    end
  end
end
