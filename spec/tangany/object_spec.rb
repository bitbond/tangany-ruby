# frozen_string_literal: true

RSpec.describe(Tangany::Object) do
  context "from a response" do
    subject(:object) { Tangany::Customers::Customer.new(id: id) }

    let(:id) { "cus_123" }

    context "#to_json" do
      it "returns a JSON string with the correct attributes" do
        expect(object.to_json).to(be_a(String))
        expect(object.to_json).to(eq("{\"id\":\"cus_123\"}"))
      end
    end
  end
end
