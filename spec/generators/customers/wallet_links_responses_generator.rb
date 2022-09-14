module Tangany
  module Customers
    class WalletLinksResponsesGenerator
      attr_reader :inputs_root_folder, :responses_root_folder

      def initialize
        @inputs_root_folder = "spec/fixtures/generated/inputs/customers/wallet_links"
        @responses_root_folder = "spec/fixtures/generated/responses/customers/wallet_links"
      end

      def create
        # cleanup
        cleanup("create")

        # created
        File.write("#{responses_root_folder}/create/created.json", JSON.pretty_generate({}))

        # conflicting
        customer_id = JSON.parse(File.read("#{inputs_root_folder}/create/valid_input.json"))["id"]
        File.write("#{responses_root_folder}/create/conflicting.json", JSON.pretty_generate({
          statusCode: 409,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "WalletLink with ID \"#{customer_id}\" already exists."
        }))
      end

      def list
        # cleanup
        cleanup("list")

        # empty
        File.write("#{responses_root_folder}/list/empty.json", JSON.pretty_generate(list_response_from_wallet_links([])))

        # paginated
        wallet_links = Dir.glob("#{responses_root_folder}/retrieve/*.json").map do |file|
          id = File.basename(file, ".json")
          next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

          id
        end.compact.sort
        File.write("#{responses_root_folder}/list/paginated.json", JSON.pretty_generate(list_response_from_wallet_links(wallet_links)))
      end

      def retrieve
        # cleanup
        cleanup("retrieve")

        # valid wallet_link
        3.times do
          wallet_link = FactoryBot.build(:customers_objects_wallet_link)
          File.write("#{responses_root_folder}/retrieve/#{wallet_link.id}.json", JSON.pretty_generate(JSON.parse(wallet_link.to_json)))
        end

        # invalid wallet_link
        File.write("#{responses_root_folder}/retrieve/not_found.json", JSON.pretty_generate(not_found_response))
      end

      private

      def cleanup(folder)
        FileUtils.mkdir_p("#{responses_root_folder}/#{folder}")
        Dir.glob("#{responses_root_folder}/#{folder}/*.json").each { |file| File.delete(file) }
      end

      def list_response_from_wallet_links(wallet_links)
        {
          total: wallet_links.size,
          results: (wallet_links[1..1] || []).map do |id|
            {
              id: id,
              type: "waas",
              _links: {
                self: "/wallet-links/#{id}"
              }
            }
          end,
          _links: {
            next: wallet_links.present? ? "/wallet-links?start=2&limit=1&sort=asc" : nil,
            previous: wallet_links.present? ? "/wallet-links?start=0&limit=1&sort=asc" : nil
          }
        }
      end

      def not_found_response
        {
          statusCode: 404,
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "WalletLink with ID \"not_found\" was not found"
        }
      end
    end
  end
end
