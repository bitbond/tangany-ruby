RSpec.describe(Tangany) do
  context "with forwardable configuration" do
    context "with internal configuration" do
      describe "with customers" do
        it "returns the customers_base_url" do
          expect(described_class.customers_base_url).to(eq("https://api.tangany.com/customers"))
        end

        it "returns the customers_version" do
          expect(described_class.customers_version).to(eq("1"))
        end
      end
    end

    it "allows subscription to be configured" do
      described_class.subscription = "test"
      expect(described_class.subscription).to(eq("test"))
    end
  end
end
