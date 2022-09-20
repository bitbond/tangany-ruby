RSpec.describe Tangany::JsonPatch do
  context "when initialized" do
    subject(:json_patch) { described_class.new(old_hash, new_hash, prefix) }

    let(:old_hash) { {foo: "bar"} }
    let(:new_hash) { {foo: "baz"} }
    let(:prefix) { "" }

    context "with an invalid old_hash" do
      let(:old_hash) { "foo" }

      it "raises an ArgumentError" do
        expect { json_patch }.to raise_error(ArgumentError, "Old hash must be a Hash")
      end
    end

    context "with an invalid new_hash" do
      let(:new_hash) { "foo" }

      it "raises an ArgumentError" do
        expect { json_patch }.to raise_error(ArgumentError, "New hash must be a Hash")
      end
    end

    context "with an invalid prefix" do
      let(:prefix) { 42 }

      it "raises an ArgumentError" do
        expect { json_patch }.to raise_error(ArgumentError, "Prefix must be a String")
      end
    end
  end

  describe "#generate" do
    subject(:generate) { json_patch.generate }

    let(:json_patch) { described_class.new(old_hash, new_hash) }
    let(:old_hash) { {foo: {foo: :bar, bar: :baz, baz: :foo}} }
    let(:new_hash) { {foo: {foo: :bar, bar: :foo}, bar: :baz} }
    let(:operations) {
      [
        {op: "add", path: "/bar", value: :baz},
        {op: "remove", path: "/foo/baz"},
        {op: "replace", path: "/foo/bar", value: :foo}
      ]
    }

    it "returns an array of operations" do
      expect(json_patch.generate.sort_by { |op| op[:path] }).to eq(operations.sort_by { |op| op[:path] })
    end
  end

  describe "to_json" do
  end
end
