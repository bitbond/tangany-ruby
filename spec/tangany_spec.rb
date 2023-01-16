RSpec.describe(Tangany) do
  context "with forwardable configuration" do
    context "with internal configuration" do
      describe "with customers" do
        it { expect(described_class.customers_base_url).to(eq("https://api.tangany.com/customers")) }
        it { expect(described_class.customers_version).to(eq("1")) }
      end
    end

    %i[client_id client_secret environment subscription vault_url version].each do |attribute|
      before { described_class.send("#{attribute}=", "test") }

      it { expect(described_class.send(attribute)).to(eq("test")) }
    end
  end
end
