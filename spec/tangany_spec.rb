# frozen_string_literal: true

RSpec.describe(Tangany) do
  context "forwardable configuration" do
    context "internal configuration" do
      context "customers" do
        it "returns the customers_base_url" do
          expect(Tangany.customers_base_url).to(eq("https://api.tangany.com/customers"))
        end

        it "returns the customers_version" do
          expect(Tangany.customers_version).to(eq("1"))
        end
      end
    end

    it "allows customers_subscription to be configured" do
      Tangany.customers_subscription = "test"
      expect(Tangany.customers_subscription).to(eq("test"))
    end
  end
end
