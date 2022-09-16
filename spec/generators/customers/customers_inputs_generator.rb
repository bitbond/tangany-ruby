module Tangany
  module Customers
    class CustomersInputsGenerator
      attr_reader :inputs_root_folder, :responses_root_folder

      def initialize
        @inputs_root_folder = "spec/fixtures/generated/inputs/customers/customers"
        @responses_root_folder = "spec/fixtures/generated/responses/customers/customers"
      end

      def create
        # cleanup
        cleanup("create")

        # valid_input.json
        contract = FactoryBot.build(:customers_contracts_customers_create)
        File.write("#{inputs_root_folder}/create/valid_input.json", JSON.pretty_generate(JSON.parse(contract.to_h.to_json)))
      end

      def update
        # cleanup
        cleanup("update")

        # valid_input.json
        customer_id = File.basename(Dir.glob("#{responses_root_folder}/retrieve/*.json").min, ".json")
        contract = FactoryBot.build(:customers_contracts_customers_update, id: customer_id)
        File.write("#{inputs_root_folder}/update/valid_input.json", JSON.pretty_generate(JSON.parse(contract.to_h.to_json)))
      end

      private

      def cleanup(folder)
        FileUtils.mkdir_p("#{inputs_root_folder}/#{folder}")
        Dir.glob("#{inputs_root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end
    end
  end
end
