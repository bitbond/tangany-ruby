RSpec.describe(Tangany::Customers::Client) do
  context "when initialized" do
    subject(:client) { described_class.new }

    it {expect(client.connection).to(be_a(Faraday::Connection))}
    it {expect(client.subscription).to(eq(Tangany.subscription))}
  end
end
