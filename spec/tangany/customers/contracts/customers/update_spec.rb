RSpec.describe(Tangany::Customers::Contracts::Customers::Update) do
  subject(:to_safe_params) { described_class.new.to_safe_params!(params) }

  describe "#to_safe_params!" do
    let(:params) do
      JSON.parse(
        File.read("spec/fixtures/generated/inputs/customers/customers/update/valid_input.json"),
        symbolize_names: true
      )
    end

    context "with the contract.cancelledDate param" do
      let(:params) { super().deep_merge(contract: {cancelledDate: Date.today.to_s}) }

      context "with the contract.isCancelled param set to `true`" do
        let(:params) { super().deep_merge(contract: {isCancelled: true}) }

        it "returns the params" do
          expect(to_safe_params).to eq(params)
        end
      end

      context "with the contract.isCancelled param set to `false`" do
        let(:params) { super().deep_merge(contract: {isCancelled: false}) }

        it "raises an ArgumentError" do
          expect { to_safe_params }.to raise_error(Tangany::InputError, {
            contract: {cancelledDate: ["should be specified only if `contract.isCancelled` is true"]}
          }.to_json)
        end
      end
    end

    context "with the naturalPerson.pep.source and the naturalPerson.pep.reason param" do
      let(:params) { super().deep_merge(naturalPerson: {pep: {source: Faker::Lorem.sentence, reason: Faker::Lorem.sentence}}) }

      context "with the naturalPerson.pep.isExposed param set to `true`" do
        let(:params) { super().deep_merge(naturalPerson: {pep: {isExposed: true}}) }

        it "returns the params" do
          expect(to_safe_params).to eq(params)
        end
      end

      context "with the isExposed param set to `false`" do
        let(:params) { super().deep_merge(naturalPerson: {pep: {isExposed: false}}) }

        it "raises an ArgumentError" do
          expect { to_safe_params }.to raise_error(Tangany::InputError, {naturalPerson: {pep: {
            source: ["should be specified only if `naturalPerson.pep.isExposed` is true"],
            reason: ["should be specified only if `naturalPerson.pep.isExposed` is true"]
          }}}.to_json)
        end
      end
    end

    context "with the naturalPerson.sanctions.source and the naturalPerson.sanctions.reason param" do
      let(:params) { super().deep_merge(naturalPerson: {sanctions: {source: Faker::Lorem.sentence, reason: Faker::Lorem.sentence}}) }

      context "with the naturalPerson.sanctions.isSanctioned param set to `true`" do
        let(:params) { super().deep_merge(naturalPerson: {sanctions: {isSanctioned: true}}) }

        it "returns the params" do
          expect(to_safe_params).to eq(params)
        end
      end

      context "with the isSanctioned param set to `false`" do
        let(:params) { super().deep_merge(naturalPerson: {sanctions: {isSanctioned: false}}) }

        it "raises an ArgumentError" do
          expect { to_safe_params }.to raise_error(Tangany::InputError, {naturalPerson: {sanctions: {
            source: ["should be specified only if `naturalPerson.sanctions.isSanctioned` is true"],
            reason: ["should be specified only if `naturalPerson.sanctions.isSanctioned` is true"]
          }}}.to_json)
        end
      end
    end
  end
end
