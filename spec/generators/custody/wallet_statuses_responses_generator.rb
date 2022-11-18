module Tangany
  module Custody
    class WalletStatusesResponsesGenerator
      attr_reader :inputs_root_folder, :responses_root_folder

      def initialize
        @inputs_root_folder = "spec/fixtures/generated/inputs/customers/wallet_links"
        @responses_root_folder = "spec/fixtures/generated/responses/custody/wallet_statuses"
      end

      def retrieve
        # cleanup
        cleanup("retrieve")

        # valid wallet
        wallet_link_input = JSON.parse(File.read("#{inputs_root_folder}/create/valid_input.json"))
        wallet_status = FactoryBot.build(:custody_objects_wallet_status, address: wallet_link_input["address"], currency: wallet_link_input["assetId"])
        File.write("#{responses_root_folder}/retrieve/wal_123456789.json", JSON.pretty_generate(JSON.parse(wallet_status.to_json)))

        # invalid wallet
        File.write("#{responses_root_folder}/retrieve/not_found.json", JSON.pretty_generate(not_found_response))
      end

      private

      def cleanup(folder)
        FileUtils.mkdir_p("#{responses_root_folder}/#{folder}")
        Dir.glob("#{responses_root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end

      def not_found_response
        {
          statusCode: 404,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "No wallet found for given name: not_found"
        }
      end
    end
  end
end
