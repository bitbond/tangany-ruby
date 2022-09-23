RSpec.describe(Tangany::Customers::Contracts::Customers::Create) do
  subject(:to_safe_params) { described_class.new.to_safe_params!(params) }

  describe "#to_safe_params!" do
    let(:params) do
      JSON.parse(
        File.read("spec/fixtures/generated/inputs/customers/customers/create/valid_input.json"),
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

      context "without the contract.isCancelled param" do
        before do
          params[:contract].delete(:isCancelled)
        end

        it "raises an ArgumentError" do
          expect { to_safe_params }.to raise_error(Tangany::InputError, {
            contract: {cancelledDate: ["should be specified only if `contract.isCancelled` is true"]}
          }.to_json)
        end
      end
    end

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
