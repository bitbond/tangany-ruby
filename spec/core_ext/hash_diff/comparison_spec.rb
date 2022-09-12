# frozen_string_literal: true

RSpec.describe HashDiff::Comparison do
  let(:original_hash) { {a: 1, b: 2, c: 3} }

  describe "#to_operations_json" do
    subject(:to_operations_json) { described_class.new(merged_hash, original_hash).to_operations_json }

    context "with a new value" do
      let(:merged_hash) { {a: 1, b: 2, c: 4} }

      it "returns a JSON with an add operation" do
        expect(to_operations_json).to eq '[{"op":"replace","path":"/c","value":4}]'
      end
    end

    context "with a new key" do
      let(:merged_hash) { {a: 1, b: 2, c: 3, d: 4} }

      it "returns a JSON with a replace operation" do
        expect(to_operations_json).to eq '[{"op":"add","path":"/d","value":4}]'
      end
    end
  end
end
