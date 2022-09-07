# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersInputsGenerator
      attr_reader :root_folder

      def initialize
        @root_folder = "spec/fixtures/inputs/customers/customers"
      end

      def create
        # cleanup
        cleanup("create")

        # invalid_input.json
        File.write("#{root_folder}/create/invalid_input.json", "{ \"foo\": \"bar\" }")

        # valid_input.json
        input = FactoryBot.build(:customers_inputs_customers_create)
        File.write("#{root_folder}/create/valid_input.json", JSON.pretty_generate(JSON.parse(input.to_json)))
      end

      def update
        # cleanup
        cleanup("update")

        # invalid_input.json
        File.write("#{root_folder}/update/invalid_input.json", JSON.pretty_generate({foo: :bar}))

        # valid_input.json
        input = FactoryBot.build(:customers_inputs_customers_update)
        File.write("#{root_folder}/update/valid_input.json", JSON.pretty_generate(JSON.parse(input.to_json)))
      end

      private

      def cleanup(folder)
        Dir.glob("#{root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end
    end
  end
end
