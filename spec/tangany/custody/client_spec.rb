RSpec.describe(Tangany::Custody::Client) do
  context "when initialized" do
    subject(:client) { described_class.new }

    it "creates a connection" do
      expect(client.connection).to(be_a(Faraday::Connection))
    end

    it "has a client_id" do
      expect(client.client_id).to(eq(Tangany.client_id))
    end

    it "has a client_secret" do
      expect(client.client_secret).to(eq(Tangany.client_secret))
    end

    it "has a subscription" do
      expect(client.subscription).to(eq(Tangany.subscription))
    end

    it "has a vault_url" do
      expect(client.vault_url).to(eq(Tangany.vault_url))
    end
  end
end
