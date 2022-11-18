RSpec.describe(Tangany::Custody::Client) do
  context "when initialized" do
    subject(:client) { described_class.new }

    it { expect(client.connection).to(be_a(Faraday::Connection)) }
    it { expect(client.client_id).to(eq(Tangany.client_id)) }
    it { expect(client.client_secret).to(eq(Tangany.client_secret)) }
    it { expect(client.environment).to(eq(Tangany.environment)) }
    it { expect(client.subscription).to(eq(Tangany.subscription)) }
    it { expect(client.vault_url).to(eq(Tangany.vault_url)) }
  end
end
