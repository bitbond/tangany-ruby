# frozen_string_literal: true

RSpec.describe(Tangany::Collection) do
  context "with a response" do
    subject(:collection) { described_class.from_response(response, type: type) }

    let(:client) { Tangany::Customers::Client.new(adapter: :test, stubs: stubs) }
    let(:path) { "customers/list" }
    let(:response) do
      client.connection.get(path, {}, {"tangany-subscription" => Tangany.subscription})
    end
    let(:stubbed_response) { stub_customers_response(fixture: "customers/list/#{fixture}") }
    let(:stubs) { Faraday::Adapter::Test::Stubs.new }
    let(:type) { Tangany::Customers::Customer }

    before do
      stub_customers_request(stubs, path, response: stubbed_response)
    end

    context "with an empty resultset" do
      let(:fixture) { "empty" }

      it "initializes an empty collection" do
        expect(collection.data).to(be_empty)
      end

      it "has a total of 0" do
        expect(collection.total).to(eq(0))
      end

      it "has a nil next path" do
        expect(collection.next_path).to(be_nil)
      end

      it "has a nil previous path" do
        expect(collection.previous_path).to(be_nil)
      end
    end

    context "with a paginated resultset" do
      let(:path) { "customers?limit=1&sort=asc&start=1" }
      let(:fixture) { "paginated" }

      it "initializes a non-empty collection" do
        expect(collection.data.size).to(eq(1))
      end

      it "has a total of 3" do
        expect(collection.total).to(eq(3))
      end

      it "has a next path" do
        expect(collection.next_path).to(eq("/customers?start=2&limit=1&sort=asc"))
      end

      it "has a previous path" do
        expect(collection.previous_path).to(eq("/customers?start=0&limit=1&sort=asc"))
      end

      it "fills the collection with the correct type" do
        expect(collection.data.first).to(be_a(Tangany::Customers::Customer))
      end

      it "fills the collection with the correct attributes" do
        expected_id = fetch_expected_id
        expect(collection.data.first.id).to(eq(expected_id))
      end
    end
  end

  private

  def fetch_expected_id
    Dir.glob("spec/fixtures/generated/responses/customers/customers/retrieve/*.json").map do |file|
      id = File.basename(file, ".json")
      next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

      id
    end.compact.sort[1]
  end
end
