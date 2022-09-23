RSpec.describe(Tangany::Customers::Contracts::Customers::Update) do
  subject(:to_safe_params) { described_class.new.to_safe_params!(params) }

  describe "#to_safe_params!" do
    let(:params) { {} }

    context "with the person.pep.source and the person.pep.reason param" do
      let(:params) { super().deep_merge(person: {pep: {source: Faker::Lorem.sentence, reason: Faker::Lorem.sentence}}) }

      context "with the person.pep.isExposed param set to `true`" do
        let(:params) { super().deep_merge(person: {pep: {isExposed: true}}) }

        it "returns the params" do
          expect(to_safe_params).to eq(params)
        end
      end

      context "with the isExposed param set to `false`" do
        let(:params) { super().deep_merge(person: {pep: {isExposed: false}}) }

        it "raises an ArgumentError" do
          expect { to_safe_params }.to raise_error(Tangany::InputError, {person: {pep: {
            source: ["should be specified only if `person.pep.isExposed` is true"],
            reason: ["should be specified only if `person.pep.isExposed` is true"]
          }}}.to_json)
        end
      end
    end
  end
end
