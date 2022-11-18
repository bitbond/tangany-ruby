RSpec.describe(Tangany::Customers::WalletLinksResource) do
  let(:body) { "{}" }
  let(:client) { Tangany::Customers::Client.new(adapter: :test, stubs: stubs) }
  let(:method) { :get }
  let(:status) { 200 }
  let(:stubbed_response) { stub_customers_response(fixture: fixture, status: status) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }

  before { stub_customers_request(stubs, path, method: method, body: body, response: stubbed_response) }

  describe "#create" do
    subject(:wallet_link) { client.wallet_links.create(**input) }

    let(:body) { input.to_json }
    let(:input) do
      JSON.parse(
        File.read("spec/fixtures/generated/inputs/customers/wallet_links/create/valid_input.json"),
        symbolize_names: true
      )
    end
    let(:method) { :post }
    let(:path) { "wallet-links" }

    context "with a valid payload" do
      let(:fixture) { "wallet_links/create/created" }

      it { expect(wallet_link).to(be_a(Tangany::Customers::WalletLink)) }

      # TODO: derive wallet address from secp256k1 public key instead of using the Custody API
      context "with a wallet value" do
        let(:custody_client) { Tangany::Custody::Client.new(adapter: :test, stubs: custody_stubs) }
        let(:custody_fixture) { "wallet_statuses/retrieve/#{input[:wallet]}" }
        let(:custody_stubs) { Faraday::Adapter::Test::Stubs.new }
        let(:custody_stubbed_response) { stub_custody_response(fixture: custody_fixture, status: 200) }

        before do
          input[:wallet] = "wal_123456789"
          original_address = input.delete(:address)
          allow(Tangany::Custody::Client).to(receive(:new).and_return(custody_client))
          stub_custody_request(custody_stubs, "eth/wallet/#{input[:wallet]}", method: "get", response: custody_stubbed_response)
          hash = input.dup
          hash.delete(:wallet)
          hash[:address] = original_address
          stub_customers_request(stubs, path, method: method, body: hash.to_json, response: stubbed_response)
        end

        it { expect(wallet_link).to(be_a(Tangany::Customers::WalletLink)) }
      end
    end

    context "with a conflicting payload" do
      let(:fixture) { "wallet_links/create/conflicting" }
      let(:status) { 409 }

      it { expect { wallet_link }.to(raise_error(Tangany::RequestError).with_message("[409] A wallet link for address and given asset already exists")) }
    end
  end

  describe "#delete" do
    subject(:response) { client.wallet_links.delete(wallet_link_id) }

    let(:fixture) { "wallet_links/delete/#{wallet_link_id}" }
    let(:method) { :delete }
    let(:path) { "wallet-links/#{wallet_link_id}" }

    context "with a valid wallet link ID" do
      let(:wallet_link_id) { fetch_wallet_link_id }

      it { expect(response.body).to(eq({})) }
      it { expect { response }.not_to(raise_error) }
    end

    context "with an invalid wallet link ID" do
      let(:wallet_link_id) { "not_found" }
      let(:status) { 404 }

      it { expect { response }.to(raise_error(Tangany::RequestError).with_message("[404] Resource not found")) }
    end
  end

  describe "#list" do
    subject(:wallet_links) { client.wallet_links.list(limit: limit, sort: sort) }

    let(:fixture) { "wallet_links/list/paginated" }
    let(:limit) { 1 }
    let(:path) { "wallet-links?limit=#{limit}&sort=#{sort}" }
    let(:sort) { "asc" }

    it { expect(wallet_links).to(be_a(Tangany::Collection)) }
    it { expect(wallet_links.data.first.class).to(eq(Tangany::Customers::WalletLink)) }
    it { expect(wallet_links.total).to(eq(3)) }
    it { expect(wallet_links.next_page_token).to(eq("foo")) }
  end

  describe "#retrieve" do
    subject(:wallet_link) { client.wallet_links.retrieve(wallet_link_id) }

    let(:fixture) { "wallet_links/retrieve/#{wallet_link_id}" }
    let(:path) { "wallet-links/#{wallet_link_id}" }

    context "with a valid wallet link ID" do
      let(:wallet_link_id) { fetch_wallet_link_id }

      it { expect(wallet_link).to(be_a(Tangany::Customers::WalletLink)) }
    end

    context "with an invalid wallet link ID" do
      let(:wallet_link_id) { "not_found" }
      let(:status) { 404 }

      it { expect { wallet_link }.to(raise_error(Tangany::RequestError).with_message("[404] Resource not found")) }
    end
  end

  private

  def fetch_wallet_link_id
    Dir.glob("spec/fixtures/generated/responses/customers/wallet_links/retrieve/*.json").map do |file|
      id = File.basename(file, ".json")
      next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

      id
    end.compact.min
  end
end
