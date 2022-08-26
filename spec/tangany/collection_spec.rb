# frozen_string_literal: true

require "byebug"

RSpec.describe(Tangany::Collection) do
  context "from a response" do
    subject(:collection) { Tangany::Collection.from_response(response, type: type) }

    let(:client) { Tangany::Customers::Client.new }
    let(:type) { Tangany::Customers::Customer }

    let(:response) do
      client.connection.get("customers", {}, { "tangany-subscription" => Tangany.customers_subscription })
    end

    context "with an empty resultset" do
      it "initializes an empty collection" do
        expect(collection.data).to(be_empty)
        expect(collection.total).to(eq(0))
        expect(collection.next_cursor).to(be_nil)
        expect(collection.prev_cursor).to(be_nil)
      end
    end
  end
end
