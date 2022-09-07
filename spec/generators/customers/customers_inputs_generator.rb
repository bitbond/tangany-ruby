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
        File.open("#{root_folder}/create/invalid_input.json", "w") { |file| file.write("{ \"foo\": \"bar\" }") }

        # valid_input.json
        input = FactoryBot.build(:customers_inputs_customers_create)
        File.open("#{root_folder}/create/valid_input.json", "w") do |file|
          file.write(JSON.pretty_generate(JSON.parse(input.to_json)))
        end
      end

      def update
        # cleanup
        cleanup("update")

        # invalid_input.json
        File.open("#{root_folder}/update/invalid_input.json", "w") do |file|
          file.write(JSON.pretty_generate({ foo: :bar }))
        end

        # valid_input.json
        input = FactoryBot.build(:customers_inputs_customers_update)
        File.open("#{root_folder}/update/valid_input.json", "w") do |file|
          file.write(JSON.pretty_generate(JSON.parse(input.to_json)))
        end
      end

      private

      def cleanup(folder)
        Dir.glob("#{root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end
    end
  end
end
