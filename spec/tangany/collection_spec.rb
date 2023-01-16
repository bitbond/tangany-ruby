RSpec.describe(Tangany::Collection) do
  subject(:collection) { Tangany::Customers::Collection.from_response(response, type: type) }

  let(:client) { Tangany::Customers::Client.new(adapter: :test, stubs: stubs) }
  let(:path) { "customers/list" }
  let(:response) { client.connection.get(path) }
  let(:stubbed_response) { stub_customers_response(fixture: "customers/list/#{fixture}") }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:type) { Tangany::Customers::Customer }

  before { stub_customers_request(stubs, path, response: stubbed_response) }

  context "with an empty resultset" do
    let(:fixture) { "empty" }

    it { expect(collection.data).to(be_empty) }
    it { expect(collection.total).to(eq(0)) }
    it { expect(collection.next_path).to(be_nil) }
    it { expect(collection.previous_path).to(be_nil) }
  end

  context "with a paginated resultset" do
    let(:path) { "customers?limit=1&sort=asc" }
    let(:fixture) { "paginated" }

    it { expect(collection.data.size).to(eq(1)) }
    it { expect(collection.total).to(eq(3)) }
    it { expect(collection.next_page_token).to(eq("foo")) }
    it { expect(collection.data.first).to(be_a(Tangany::Customers::Customer)) }
    it { expect(collection.data.first.id).to(eq(fetch_expected_id)) }
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
