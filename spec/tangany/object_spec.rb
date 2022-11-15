RSpec.describe(Tangany::Object) do
  context "with a response" do
    subject(:object) { Tangany::Customers::Customer.new(attributes) }

    let(:attributes) { build(:customers_objects_customer, id: id).to_h }
    let(:id) { "cus_123" }

    describe "#to_json" do
      it { expect(object.to_json).to(be_a(String)) }
      it { expect(object.to_json).to(eq(attributes.to_json)) }
    end
  end
end
