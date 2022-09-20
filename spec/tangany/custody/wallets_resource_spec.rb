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

      it "creates a wallet" do
        expect(wallet).to(be_a(Tangany::Custody::Wallet))
      end
    end

    context "with an invalid payload" do
      let(:input) { {foo: :bar} }
      let(:fixture) { "wallets/create/created" }

      it "raises a Dry::Struct::Error" do
        expect { wallet }.to(raise_error(Tangany::InputError).with_message(/"foo":\["is not allowed"\]/))
      end
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

      it "raises an error" do
        expect { wallet }.to(
          raise_error(Tangany::RequestError)
          .with_message(/Won't overwrite existing wallet with name [^"]+/)
        )
      end
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

  describe "#retrieve" do
    subject(:wallet) { client.wallets.retrieve(wallet_id) }

    let(:fixture) { "wallets/retrieve/#{wallet_id}" }
    let(:path) { "wallet/#{wallet_id}" }

    context "with a valid wallet" do
      let(:wallet_id) { fetch_wallet_id }

      it "returns a Wallet" do
        expect(wallet).to(be_a(Tangany::Custody::Wallet))
      end
    end

    context "with an invalid wallet" do
      let(:wallet_id) { "not_found" }
      let(:status) { 404 }

      it "raises an error" do
        expect { wallet }.to(
          raise_error(Tangany::RequestError)
          .with_message("No wallet found for given name: #{wallet_id}")
        )
      end
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
          safe_params = Tangany::Custody::Wallets::UpdateContract.new.to_safe_params!(params)
          merged_hash = wallet_hash.deep_merge(safe_params)
          Tangany::JsonPatch.new(wallet_hash, merged_hash).generate.to_json
        end
        let(:params) do
          JSON.parse(
            File.read("spec/fixtures/generated/inputs/custody/wallets/update/valid_input.json"),
            symbolize_names: true
          )
        end

        it "updates the wallet" do
          expect(wallet).to(be_a(Tangany::Custody::Wallet))
        end
      end

      context "with an invalid payload" do
        let(:params) { {wallet: wallet_id, foo: :bar} }

        it "raises a Dry::Struct::Error" do
          expect { wallet }.to(raise_error(Tangany::InputError).with_message(/"foo":\["is not allowed"\]/))
        end
      end

      context "with a conflicting If-Match precondition" do
        let(:status) { 412 }

        it "raises an error" do
          expect { wallet }.to(
            raise_error(Tangany::RequestError)
            .with_message("Mid-air edit collision detected")
          )
        end
      end
    end

    context "with an invalid wallet" do
      let(:wallet_id) { "not_found" }
      let(:status) { 404 }

      it "raises an error" do
        expect { wallet }.to(
          raise_error(Tangany::RequestError)
          .with_message("No wallet found for given name: #{wallet_id}")
        )
      end
    end
  end

  private

  def fetch_wallet_id
    Dir.glob("spec/fixtures/generated/responses/custody/wallets/retrieve/*.json").map do |file|
      id = File.basename(file, ".json")
      next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

      id
    end.compact.min
  end
end
