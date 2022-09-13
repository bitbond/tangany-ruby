# frozen_string_literal: true

module Tangany
  module Customers
    class CustomersContractsGenerator
      attr_reader :contracts_root_folder, :responses_root_folder

      def initialize
        @contracts_root_folder = "spec/fixtures/contracts/customers/customers"
        @responses_root_folder = "spec/fixtures/responses/customers/customers"
      end

      def create
        # cleanup
        cleanup("create")

        # valid_contract.json
        contract = FactoryBot.build(:customers_contracts_customers_create)
        File.write("#{contracts_root_folder}/create/valid_contract.json", JSON.pretty_generate(JSON.parse(contract.to_json)))
      end

      def update
        # cleanup
        cleanup("update")

        # valid_contract.json
        customer_id = File.basename(Dir.glob("#{responses_root_folder}/retrieve/*.json").min, ".json")
        contract = FactoryBot.build(:customers_contracts_customers_update, id: customer_id)
        File.write("#{contracts_root_folder}/update/valid_contract.json", JSON.pretty_generate(JSON.parse(contract.to_json)))
      end

      private

      def cleanup(folder)
        FileUtils.mkdir_p("#{contracts_root_folder}/#{folder}")
        Dir.glob("#{contracts_root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end
    end
  end
end
