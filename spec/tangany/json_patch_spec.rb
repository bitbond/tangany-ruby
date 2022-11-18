RSpec.describe Tangany::JsonPatch do
  let(:json_patch) { described_class.new(old_hash, new_hash, prefix) }
  let(:new_hash) { {foo: {foo: :bar, bar: :foo}, bar: :baz} }
  let(:old_hash) { {foo: {foo: :bar, bar: :baz, baz: :foo}} }
  let(:operations) {
    [
      {op: "add", path: "/bar", value: :baz},
      {op: "remove", path: "/foo/baz"},
      {op: "replace", path: "/foo/bar", value: :foo}
    ]
  }
  let(:prefix) { "" }

  context "when initialized" do
    context "with an invalid old_hash" do
      let(:old_hash) { "foo" }

      it { expect { json_patch }.to raise_error(ArgumentError, "Old hash must be a Hash") }
    end

    context "with an invalid new_hash" do
      let(:new_hash) { "foo" }

      it { expect { json_patch }.to raise_error(ArgumentError, "New hash must be a Hash") }
    end

    context "with an invalid prefix" do
      let(:prefix) { 42 }

      it { expect { json_patch }.to raise_error(ArgumentError, "Prefix must be a String") }
    end
  end

  describe "#generate" do
    before do
      json_patch.generate
    end

    it { expect(json_patch.operations.sort_by { |op| op[:path] }).to eq(operations.sort_by { |op| op[:path] }) }
  end

  describe "to_json" do
    before do
      json_patch.generate
    end

    it { expect(json_patch.to_json).to eq(json_patch.operations.to_json) }
  end
end
