module Tangany
  module Custody
    class WalletsInputsGenerator
      attr_reader :inputs_root_folder, :responses_root_folder

      def initialize
        @inputs_root_folder = "spec/fixtures/generated/inputs/custody/wallets"
        @responses_root_folder = "spec/fixtures/generated/responses/custody/wallets"
      end

      def create
        # cleanup
        cleanup("create")

        # valid_input.json
        safe_params = FactoryBot.build(:custody_contracts_wallets_create)
        File.write("#{inputs_root_folder}/create/valid_input.json", JSON.pretty_generate(JSON.parse(safe_params.to_json)))
      end

      private

      def cleanup(folder)
        FileUtils.mkdir_p("#{inputs_root_folder}/#{folder}")
        Dir.glob("#{inputs_root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end
    end
  end
end
