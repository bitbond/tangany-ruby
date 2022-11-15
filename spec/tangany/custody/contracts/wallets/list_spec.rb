RSpec.describe(Tangany::Custody::Contracts::Wallets::List) do
  subject(:to_safe_params) { described_class.new.to_safe_params!(params) }

  describe "#to_safe_params!" do
    let(:params) { {} }

    context "without any params" do
      it { expect(to_safe_params).to eq({}) }
    end

    context "with the sort param" do
      let(:params) { super().merge({sort: "desc"}) }

      context "with the order param set to `created`" do
        let(:params) { super().merge(order: "created") }

        it { expect(to_safe_params).to eq({sort: "createddesc"}) }
      end

      context "without the order param" do
        it { expect { to_safe_params }.to raise_error(Tangany::InputError, {sort: ["should not be specified without `order`"]}.to_json) }
      end
    end
  end
end
