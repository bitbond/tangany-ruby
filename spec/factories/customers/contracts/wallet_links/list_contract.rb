FactoryBot.define do
  factory :customers_contracts_wallet_links_list, class: "Tangany::Customers::Contracts::WalletLinks::List" do
    initialize_with { new.to_safe_params!(attributes) }

    pageToken { "foo" }
    limit { 1 }
    sort { "asc" }
  end
end
