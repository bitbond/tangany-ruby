# frozen_string_literal: true

RSpec.describe(Tangany::Customers::WalletLinksResource) do
  let(:body) { "{}" }
  let(:client) { Tangany::Customers::Client.new(adapter: :test, stubs: stubs) }
  let(:method) { :get }
  let(:status) { 200 }
  let(:stubbed_response) { stub_customers_response(fixture: fixture, status: status) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }

  before do
    stub_customers_request(stubs, path, method: method, body: body, response: stubbed_response)
  end

  describe "#list" do
    subject(:wallet_links) { client.wallet_links.list(limit: limit, sort: sort, start: start) }

    let(:fixture) { "wallet_links/list/paginated" }
    let(:limit) { 1 }
    let(:path) { "wallet-links?limit=#{limit}&sort=#{sort}&start=#{start}" }
    let(:start) { 1 }
    let(:sort) { "asc" }

    it "returns a collection" do
      expect(wallet_links).to(be_a(Tangany::Collection))
    end

    it "returns a collection of wallet_links" do
      expect(wallet_links.data.first.class).to(eq(Tangany::Customers::WalletLink))
    end

    it "has a total of 3" do
      expect(wallet_links.total).to(eq(3))
    end

    it "has a next path" do
      expect(wallet_links.next_path).to(eq("/wallet-links?start=2&limit=1&sort=asc"))
    end

    it "has a previous path" do
      expect(wallet_links.previous_path).to(eq("/wallet-links?start=0&limit=1&sort=asc"))
    end
  end
end
