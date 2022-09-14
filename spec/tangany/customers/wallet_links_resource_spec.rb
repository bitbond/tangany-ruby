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

  describe "#create" do
    subject(:wallet_link) { client.wallet_links.create(**contract) }

    let(:body) { contract.to_h.to_json }
    let(:method) { :post }
    let(:path) { "wallet-links" }

    context "with a valid payload" do
      let(:contract) do
        JSON.parse(
          File.read("spec/fixtures/generated/inputs/customers/wallet_links/create/valid_input.json"),
          symbolize_names: true
        )
      end
      let(:fixture) { "wallet_links/create/created" }

      it "creates a wallet link" do
        expect { wallet_link }.not_to(raise_error)
      end
    end

    context "with an invalid payload" do
      let(:contract) { {foo: :bar} }
      let(:fixture) { "wallet_links/create/created" }

      it "raises a Dry::Struct::Error" do
        expect { wallet_link }.to(raise_error(Tangany::InputError).with_message(/"foo":\["is not allowed"\]/))
      end
    end

    context "with a conflicting payload" do
      let(:contract) do
        JSON.parse(
          File.read("spec/fixtures/generated/inputs/customers/wallet_links/create/valid_input.json"),
          symbolize_names: true
        )
      end
      let(:fixture) { "wallet_links/create/conflicting" }
      let(:status) { 409 }

      it "raises an error" do
        expect { wallet_link }.to(
          raise_error(Tangany::RequestError)
          .with_message(/WalletLink with ID "[^"]+" already exists/)
        )
      end
    end
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
