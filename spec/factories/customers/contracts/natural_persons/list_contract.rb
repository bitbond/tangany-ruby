FactoryBot.define do
  factory :customers_contracts_natural_persons_list, class: "Tangany::Customers::Contracts::NaturalPersons::List" do
    initialize_with { new.to_safe_params!(attributes) }

    pageToken { "foo" }
    limit { 1 }
    sort { "asc" }
  end
end
