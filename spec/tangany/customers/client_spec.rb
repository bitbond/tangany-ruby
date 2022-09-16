RSpec.describe(Tangany::Customers::Client) do
  context "when initialized" do
    subject(:client) { described_class.new }

    it "creates a connection" do
      expect(client.connection).to(be_a(Faraday::Connection))
    end

    it "has a subscription" do
      expect(client.subscription).to(eq(Tangany.subscription))
    end
  end
end
