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

  describe "#create" do
    subject(:wallet) { client.wallets.create(**input) }

    let(:body) { input.to_json }
    let(:method) { :post }
    let(:path) { "wallets" }

    context "with a valid payload" do
      let(:input) do
        JSON.parse(
          File.read("spec/fixtures/generated/inputs/custody/wallets/create/valid_input.json"),
          symbolize_names: true
        )
      end
      let(:fixture) { "wallets/create/created" }

      it { expect(wallet).to(be_a(Tangany::Custody::Wallet)) }
    end

    context "with an invalid payload" do
      let(:input) { {foo: :bar} }
      let(:fixture) { "wallets/create/created" }

      it { expect { wallet }.to(raise_error(Tangany::InputError).with_message(/"foo":\["is not allowed"\]/)) }
    end

    context "with a conflicting payload" do
      let(:input) do
        JSON.parse(
          File.read("spec/fixtures/generated/inputs/custody/wallets/create/valid_input.json"),
          symbolize_names: true
        )
      end
      let(:fixture) { "wallets/create/conflicting" }
      let(:status) { 409 }

      it { expect { wallet }.to(raise_error(Tangany::RequestError).with_message(/Won't overwrite existing wallet with name [^"]+/)) }
    end
  end

  describe "#delete" do
    subject(:wallet_recovery) { client.wallets.delete(wallet_id) }

    let(:fixture) { "wallets/delete/#{wallet_id}" }
    let(:method) { :delete }
    let(:path) { "wallet/#{wallet_id}" }

    context "with a valid wallet" do
      let(:wallet_id) { fetch_wallet_id }

      it { expect(wallet_recovery).to(be_a(Tangany::Custody::WalletRecovery)) }
    end

    context "with an invalid wallet" do
      let(:wallet_id) { "not_found" }
      let(:status) { 404 }

      it { expect { wallet_recovery }.to(raise_error(Tangany::RequestError).with_message("[404] No wallet found for given name: #{wallet_id}")) }
    end
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

    it { expect(wallets).to(be_a(Tangany::Collection)) }
    it { expect(wallets.data.first.class).to(eq(Tangany::Custody::Wallet)) }
    it { expect(wallets.total).to(eq(3)) }
    it { expect(wallets.next_path).to(eq("/wallets?index=2&limit=1&sort=#{sort}")) }
    it { expect(wallets.previous_path).to(eq("/wallets?index=0&limit=1&sort=#{sort}")) }
  end

  describe "#retrieve" do
    subject(:wallet) { client.wallets.retrieve(wallet_id) }

    let(:fixture) { "wallets/retrieve/#{wallet_id}" }
    let(:path) { "wallet/#{wallet_id}" }

    context "with a valid wallet" do
      let(:wallet_id) { fetch_wallet_id }

      it { expect(wallet).to(be_a(Tangany::Custody::Wallet)) }
    end

    context "with an invalid wallet" do
      let(:wallet_id) { "not_found" }
      let(:status) { 404 }

      it { expect { wallet }.to(raise_error(Tangany::RequestError).with_message("[404] No wallet found for given name: #{wallet_id}")) }
    end
  end

  describe "#update" do
    subject(:wallet) { client.wallets.update(wallet_id, **params) }

    let(:fixture) { "wallets/update/#{wallet_id}" }
    let(:if_match_header) { "etag" }
    let(:method) { :patch }
    let(:params) { {} }
    let(:path) { "wallet/#{wallet_id}" }

    before do
      stub_custody_request(
        stubs,
        path,
        method: :get,
        response: stub_custody_response(
          fixture: "wallets/retrieve/#{wallet_id}",
          headers: {"If-Match" => if_match_header},
          status: status
        )
      )
    end

    context "with a valid wallet" do
      let(:wallet_id) { fetch_wallet_id }
      let(:fixture) { "wallets/update/updated" }

      context "with a valid payload" do
        let(:body) do
          wallet_hash = Tangany::Custody::Wallet.new(JSON.parse(
            File.read("spec/fixtures/generated/responses/custody/wallets/retrieve/#{wallet_id}.json"),
            symbolize_names: true
          )).to_h
          safe_params = Tangany::Custody::Contracts::Wallets::Update.new.to_safe_params!(params)
          merged_hash = wallet_hash.deep_merge(safe_params)
          Tangany::JsonPatch.new(wallet_hash, merged_hash).generate.to_json
        end
        let(:params) do
          JSON.parse(
            File.read("spec/fixtures/generated/inputs/custody/wallets/update/valid_input.json"),
            symbolize_names: true
          )
        end

        it { expect(wallet).to(be_a(Tangany::Custody::Wallet)) }
      end

      context "with an invalid payload" do
        let(:params) { {wallet: wallet_id, foo: :bar} }

        it { expect { wallet }.to(raise_error(Tangany::InputError).with_message(/"foo":\["is not allowed"\]/)) }
      end
    end

    context "with an invalid wallet" do
      let(:wallet_id) { "not_found" }
      let(:status) { 404 }

      it { expect { wallet }.to(raise_error(Tangany::RequestError).with_message("[404] No wallet found for given name: #{wallet_id}")) }
    end
  end

  private

  def fetch_wallet_id
    Dir.glob("spec/fixtures/generated/responses/custody/wallets/retrieve/*.json").map do |file|
      id = File.basename(file, ".json")
      next unless id.match?(/^wallet-/)

      id
    end.compact.min
  end
end
