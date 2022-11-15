module Tangany
  module Customers
    class WalletLinksInputsGenerator
      attr_reader :inputs_root_folder, :responses_root_folder

      def initialize
        @inputs_root_folder = "spec/fixtures/generated/inputs/customers/wallet_links"
        @responses_root_folder = "spec/fixtures/generated/responses/customers/wallet_links"
      end

      def create
        # cleanup
        cleanup("create")

        # valid_input.json
        safe_params = FactoryBot.build(:customers_contracts_wallet_links_create)
        File.write("#{inputs_root_folder}/create/valid_input.json", JSON.pretty_generate(JSON.parse(safe_params.to_json)))
      end

      def list
        # cleanup
        cleanup("list")

        # valid_input.json
        safe_params = FactoryBot.build(:customers_contracts_wallet_links_list)
        File.write("#{inputs_root_folder}/list/valid_input.json", JSON.pretty_generate(JSON.parse(safe_params.to_json)))
      end

      private

      def cleanup(folder)
        FileUtils.mkdir_p("#{inputs_root_folder}/#{folder}")
        Dir.glob("#{inputs_root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end
    end
  end
end
