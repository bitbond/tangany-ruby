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
        file = fetch_wallet_link_file_name
        FileUtils.cp(file, "#{responses_root_folder}/create/created.json")

        # conflicting
        File.write("#{responses_root_folder}/create/conflicting.json", JSON.pretty_generate({
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "A wallet link for address and given asset already exists",
          statusCode: 409
        }))
      end

      def delete
        # cleanup
        cleanup("delete")

        # deleted
        wallet_link_id = File.basename(fetch_wallet_link_file_name, ".json")
        File.write("#{responses_root_folder}/delete/#{wallet_link_id}.json", "{}")

        # invalid customer
        File.write("#{responses_root_folder}/delete/not_found.json", JSON.pretty_generate(not_found_response))
      end

      def list
        # cleanup
        cleanup("list")

        # empty
        File.write("#{responses_root_folder}/list/empty.json", JSON.pretty_generate(list_response_from_wallet_links([])))

        # paginated
        wallet_links = Dir.glob("#{responses_root_folder}/retrieve/*.json").map do |file|
          next unless File.basename(file, ".json").match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

          JSON.parse(File.read(file))
        end.compact.sort_by { |a| a["id"] }
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

      def fetch_wallet_link_file_name
        Dir.glob("#{responses_root_folder}/retrieve/*.json").map do |file|
          id = File.basename(file, ".json")
          next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

          file
        end.compact.min
      end

      def list_response_from_wallet_links(wallet_links)
        {
          nextPageToken: wallet_links.size > 1 ? "foo" : nil,
          pageInfo: {
            totalResults: wallet_links.size,
            resultsPerPage: 100
          },
          items: (wallet_links[1..1] || []).map.to_a
        }
      end

      def not_found_response
        {
          activityId: "5911c614-219c-41df-a350-50c4a50e4a6d",
          message: "Resource not found",
          statusCode: 404
        }
      end
    end
  end
end
