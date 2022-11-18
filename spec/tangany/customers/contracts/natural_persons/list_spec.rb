RSpec.describe(Tangany::Customers::Contracts::NaturalPersons::List) do
  subject(:to_safe_params!) { described_class.new.to_safe_params!(params) }

  describe "#to_safe_params!" do
    let(:params) do
      JSON.parse(
        File.read("spec/fixtures/generated/inputs/customers/natural_persons/list/valid_input.json"),
        symbolize_names: true
      )
    end

    it { expect(to_safe_params!).to(eq(params)) }

    context "with invalid params" do
      let(:params) { {foo: :bar} }

      it { expect { to_safe_params! }.to(raise_error(Tangany::InputError).with_message(/"foo":\["is not allowed"\]/)) }
    end
  end
end
