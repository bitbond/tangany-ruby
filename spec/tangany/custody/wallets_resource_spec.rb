RSpec.describe(Tangany::Custody::WalletsResource) do
  let(:body) { "{}" }
  let(:client) { Tangany::Custody::Client.new(adapter: :test, stubs: stubs) }
  let(:method) { :get }
  let(:status) { 200 }
  let(:stubbed_response) { stub_custody_response(fixture: fixture, status: status) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }

  before do
    stub_custody_request(stubs, path, method: method, body: body, response: stubbed_response)
  end

  describe "#list" do
    subject(:wallets) { client.wallets.list(limit: limit, order: order, sort: sort, start: start, tags: tags, xtags: xtags) }

    let(:fixture) { "wallets/list/paginated" }
    let(:limit) { 1 }
    let(:order) { "wallet" }
    let(:path) { "wallets?index=1&limit=1&sort=wallet&tags=tag&xtags=xtag" }
    let(:start) { 1 }
    let(:sort) { "asc" }
    let(:tags) { [:tag] }
    let(:xtags) { [:xtag] }

    it "returns a collection" do
      expect(wallets).to(be_a(Tangany::Collection))
    end

    it "returns a collection of wallets" do
      expect(wallets.data.first.class).to(eq(Tangany::Custody::Wallet))
    end

    it "has a total of 3" do
      expect(wallets.total).to(eq(3))
    end

    it "has a next path" do
      expect(wallets.next_path).to(eq("/wallets?index=2&limit=1&sort=#{sort}"))
    end

    it "has a previous path" do
      expect(wallets.previous_path).to(eq("/wallets?index=0&limit=1&sort=#{sort}"))
    end
  end
end
