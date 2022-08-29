# frozen_string_literal: true

RSpec.describe(Tangany::Customers::CustomersResource) do
  context "#list" do
    subject(:customers) { client.customers.list(limit: limit, start: start) }

    let(:client) { Tangany::Customers::Client.new(adapter: :test, stubs: stubbed_request) }
    let(:limit) { 1 }
    let(:path) { "customers?limit=#{limit}&start=#{start}" }
    let(:start) { 1 }
    let(:stubbed_request) do
      stub_customers_request(path, response: stubbed_response)
    end
    let(:stubbed_response) { stub_customers_response(fixture: "customers/paginated") }

    it "returns a paginated collection of customers" do
      expect(customers.class).to(eq(Tangany::Collection))
      expect(customers.data.first.class).to(eq(Tangany::Customers::Customer))
      expect(customers.total).to(eq(3))
      expect(customers.next_path).to(eq("/customers?start=2&limit=1"))
      expect(customers.previous_path).to(eq("/customers?start=0&limit=1"))
    end
  end
end
