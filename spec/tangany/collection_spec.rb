# frozen_string_literal: true

RSpec.describe(Tangany::Collection) do
  context "from a response" do
    subject(:collection) { Tangany::Collection.from_response(response, type: type) }

    let(:client) { Tangany::Customers::Client.new(adapter: :test, stubs: stubbed_request) }
    let(:path) { "customers" }
    let(:response) do
      client.connection.get(path, {}, { "tangany-subscription" => Tangany.customers_subscription })
    end
    let(:stubbed_request) { stub_customers_request(path, response: stubbed_response) }
    let(:stubbed_response) { stub_customers_response(fixture: "customers/#{fixture}") }
    let(:type) { Tangany::Customers::Customer }

    context "with an empty resultset" do
      let(:fixture) { "empty" }

      it "initializes an empty collection" do
        expect(collection.data).to(be_empty)
        expect(collection.total).to(eq(0))
        expect(collection.next_path).to(be_nil)
        expect(collection.previous_path).to(be_nil)
      end
    end

    context "with a non-empty resultset" do
      let(:fixture) { "non-empty" }

      it "initializes a non-empty collection" do
        expect(collection.data.size).to(eq(1))
        expect(collection.total).to(eq(1))
        expect(collection.next_path).to(be_nil)
        expect(collection.previous_path).to(be_nil)
      end

      it "fills the collection with the correct type" do
        expect(collection.data.first).to(be_a(Tangany::Customers::Customer))
      end

      it "fills the collection with the correct attributes" do
        expect(collection.data.first.id).to(eq("5a32f085-ac72-4765-a9ec-1e81f61446b2"))
      end
    end

    context "with a paginated resultset" do
      let(:path) { "customers?limit=1&start=1" }
      let(:fixture) { "paginated" }

      it "initializes a paginated collection" do
        expect(collection.data.size).to(eq(1))
        expect(collection.total).to(eq(3))
        expect(collection.next_path).to(eq("/customers?start=2&limit=1"))
        expect(collection.previous_path).to(eq("/customers?start=0&limit=1"))
      end

      it "fills the collection with the correct type" do
        expect(collection.data.first).to(be_a(Tangany::Customers::Customer))
      end

      it "fills the collection with the correct attributes" do
        expect(collection.data.first.id).to(eq("2f7d3c3b-7e93-46c7-8ffb-54c4f1771e5b"))
      end
    end
  end
end
