module Tangany
  module Custody
    class WalletsResponsesGenerator
      attr_reader :inputs_root_folder, :responses_root_folder

      def initialize
        @inputs_root_folder = "spec/fixtures/generated/inputs/custody/wallets"
        @responses_root_folder = "spec/fixtures/generated/responses/custody/wallets"
      end

      def create
        # cleanup
        cleanup("create")

        # created
        file = fetch_wallet_file_name
        FileUtils.cp(file, "#{responses_root_folder}/create/created.json")

        # conflicting
        wallet = JSON.parse(File.read("#{inputs_root_folder}/create/valid_input.json"))["wallet"]
        File.write("#{responses_root_folder}/create/conflicting.json", JSON.pretty_generate({
          statusCode: 409,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Won't overwrite existing wallet with name #{wallet}"
        }))
      end

      def delete
        # cleanup
        cleanup("delete")

        # deleted
        wallet_id = File.basename(fetch_wallet_file_name, ".json")
        File.write("#{responses_root_folder}/delete/#{wallet_id}.json", JSON.pretty_generate({
          recoveryId: wallet_id,
          scheduledPurgeDate: (Time.now + 90 * 24 * 60 * 60).utc.iso8601(3)
        }))

        # invalid wallet
        File.write("#{responses_root_folder}/delete/not_found.json", JSON.pretty_generate(not_found_response))
      end

      def list
        # cleanup
        cleanup("list")

        # empty
        File.write("#{responses_root_folder}/list/empty.json", JSON.pretty_generate(list_response_from_wallets([])))

        # paginated
        wallets = Dir.glob("#{responses_root_folder}/retrieve/*.json").map do |file|
          id = File.basename(file, ".json")
          next unless id.match?(/^wallet-/)

          id
        end.compact.sort
        File.write("#{responses_root_folder}/list/paginated.json", JSON.pretty_generate(list_response_from_wallets(wallets)))
      end

      def retrieve
        # cleanup
        cleanup("retrieve")

        # valid wallets
        3.times do
          wallet = FactoryBot.build(:custody_objects_wallet)
          File.write("#{responses_root_folder}/retrieve/#{wallet.wallet}.json", JSON.pretty_generate(JSON.parse(wallet.to_json)))
        end

        # invalid wallet
        File.write("#{responses_root_folder}/retrieve/not_found.json", JSON.pretty_generate(not_found_response))
      end

      def update
        # cleanup
        cleanup("update")

        # updated
        file = fetch_wallet_file_name
        FileUtils.cp(file, "#{responses_root_folder}/update/updated.json")

        # invalid wallet
        File.write("#{responses_root_folder}/update/not_found.json", JSON.pretty_generate(not_found_response))
      end

      private

      def cleanup(folder)
        FileUtils.mkdir_p("#{responses_root_folder}/#{folder}")
        Dir.glob("#{responses_root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end

      def deleted_response
        {
          statusCode: 404,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Customer with ID \"deleted\" has been deleted"
        }
      end

      def fetch_wallet_file_name
        Dir.glob("#{responses_root_folder}/retrieve/*.json").map do |file|
          id = File.basename(file, ".json")
          next unless id.match?(/^wallet-/)

          file
        end.compact.min
      end

      def list_response_from_wallets(wallets)
        {
          hits: {
            total: wallets.size,
            hsm: 0
          },
          list: (wallets[1..1] || []).map do |wallet|
            {
              wallet: wallet,
              links: [{
                href: "/wallet/#{wallet}",
                type: "GET",
                rel: "wallet"
              }, {
                href: "/wallet/#{wallet}",
                type: "PATCH",
                rel: "wallet"
              }, {
                href: "/wallet/#{wallet}",
                type: "PUT",
                rel: "wallet"
              }, {
                href: "/wallet/#{wallet}",
                type: "DELETE",
                rel: "wallet"
              }]
            }
          end,
          links: {
            next: wallets ? "/wallets?index=2&limit=1&sort=asc" : nil,
            previous: wallets ? "/wallets?index=0&limit=1&sort=asc" : nil
          }
        }
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
