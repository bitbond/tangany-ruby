# frozen_string_literal: true

RSpec.describe(Tangany::Object) do
  context "with a response" do
    subject(:object) { Tangany::Customers::Customer.new(id: id) }

    let(:id) { "cus_123" }

    describe "#to_json" do
      it "returns a JSON string" do
        expect(object.to_json).to(be_a(String))
      end

      it "returns a JSON string with the correct attributes" do
        expect(object.to_json).to(eq("{\"id\":\"cus_123\"}"))
      end
    end
  end
end
