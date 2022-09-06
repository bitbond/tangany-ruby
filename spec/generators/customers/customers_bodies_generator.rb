# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersBodiesGenerator
      attr_reader :root_folder

      def initialize
        @root_folder = "spec/fixtures/bodies/customers/customers"
      end

      def create
        # cleanup
        cleanup("create")

        # invalid-payload.json
        File.open("#{root_folder}/create/invalid-payload.json", "w") { |file| file.write("{ \"foo\": \"bar\" }") }

        # valid-payload.json
        body = FactoryBot.build(:customers_bodies_customers_create)
        File.open("#{root_folder}/create/valid-payload.json", "w") do |file|
          file.write(JSON.pretty_generate(JSON.parse(body.to_json)))
        end
      end

      def update
        # cleanup
        cleanup("update")

        # invalid-payload.json
        File.open("#{root_folder}/update/invalid-payload.json", "w") { |file| file.write("[{ \"foo\": \"bar\" }]") }
      end

      private

      def cleanup(folder)
        Dir.glob("#{root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end
    end
  end
end
