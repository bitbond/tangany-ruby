RSpec.describe Tangany::RequestError do
  describe "#new" do
    subject(:error) { described_class.new(message, validation_errors: validation_errors) }

    let(:message) { "foo" }

    context "without validation errors" do
      let(:validation_errors) { nil }

      it { expect(error.message).to eq("[] foo") }
    end

    context "with some validation errors" do
      let(:validation_errors) {
        [{
          message: "bar",
          source: "baz"
        }]
      }

      it { expect(error.message).to eq("[] foo Validation errors: baz: bar") }
    end
  end
end
