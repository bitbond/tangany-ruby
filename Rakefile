require "byebug"
require "bundler/gem_tasks"
require "factory_bot"
require "rspec/core/rake_task"

require_relative "spec/generators"

desc "Checks the quality of code and generate reports"
task :quality_check do
  puts
  puts "== Patch-level verification for bundler ".ljust(80, "=")
  puts
  abort unless system("bundle-audit update && bundle-audit")

  puts "== Quality report generation ".ljust(80, "=")
  puts
  paths = FileList.new(
    "lib/**/*.rb"
  ).join(" ")
  abort unless system("rubycritic #{paths}")
end

desc "Regenerates the fixtures"
task :regenerate_fixtures do
  puts
  puts "== Regenerating customers fixtures ".ljust(80, "=")

  # Customers API

  ## Natural persons

  puts " -> Regenerating responses/customers/natural_persons/retrieve"
  Tangany::Customers::NaturalPersonsResponsesGenerator.new.retrieve

  puts " -> Regenerating inputs/customers/natural_persons/list"
  Tangany::Customers::NaturalPersonsInputsGenerator.new.list

  puts " -> Regenerating responses/customers/natural_persons/list"
  Tangany::Customers::NaturalPersonsResponsesGenerator.new.list

  puts " -> Regenerating inputs/customers/natural_persons/create"
  Tangany::Customers::NaturalPersonsInputsGenerator.new.create

  puts " -> Regenerating responses/customers/natural_persons/create"
  Tangany::Customers::NaturalPersonsResponsesGenerator.new.create

  puts " -> Regenerating inputs/customers/natural_persons/update"
  Tangany::Customers::NaturalPersonsInputsGenerator.new.update

  puts " -> Regenerating responses/customers/natural_persons/update"
  Tangany::Customers::NaturalPersonsResponsesGenerator.new.update

  puts " -> Regenerating responses/customers/natural_persons/delete"
  Tangany::Customers::NaturalPersonsResponsesGenerator.new.delete

  ## Customers

  puts " -> Regenerating responses/customers/customers/retrieve"
  Tangany::Customers::CustomersResponsesGenerator.new.retrieve

  puts " -> Regenerating inputs/customers/customers/list"
  Tangany::Customers::CustomersInputsGenerator.new.list

  puts " -> Regenerating responses/customers/customers/list"
  Tangany::Customers::CustomersResponsesGenerator.new.list

  puts " -> Regenerating inputs/customers/customers/create"
  Tangany::Customers::CustomersInputsGenerator.new.create

  puts " -> Regenerating responses/customers/customers/create"
  Tangany::Customers::CustomersResponsesGenerator.new.create

  puts " -> Regenerating inputs/customers/customers/update"
  Tangany::Customers::CustomersInputsGenerator.new.update

  puts " -> Regenerating responses/customers/customers/update"
  Tangany::Customers::CustomersResponsesGenerator.new.update

  puts " -> Regenerating responses/customers/customers/delete"
  Tangany::Customers::CustomersResponsesGenerator.new.delete

  ## Wallet links

  puts " -> Regenerating responses/customers/wallet_links/retrieve"
  Tangany::Customers::WalletLinksResponsesGenerator.new.retrieve

  puts " -> Regenerating inputs/customers/wallet-links/list"
  Tangany::Customers::WalletLinksInputsGenerator.new.list

  puts " -> Regenerating responses/customers/wallet_links/list"
  Tangany::Customers::WalletLinksResponsesGenerator.new.list

  puts " -> Regenerating inputs/customers/wallet_links/create"
  Tangany::Customers::WalletLinksInputsGenerator.new.create

  puts " -> Regenerating responses/customers/wallet_links/create"
  Tangany::Customers::WalletLinksResponsesGenerator.new.create

  puts " -> Regenerating responses/customers/wallet_links/delete"
  Tangany::Customers::WalletLinksResponsesGenerator.new.delete

  # Custody API

  ## Wallets

  puts " -> Regenerating responses/custody/wallets/retrieve"
  Tangany::Custody::WalletsResponsesGenerator.new.retrieve

  puts " -> Regenerating responses/custody/wallets/list"
  Tangany::Custody::WalletsResponsesGenerator.new.list

  puts " -> Regenerating inputs/custody/wallets/create"
  Tangany::Custody::WalletsInputsGenerator.new.create

  puts " -> Regenerating responses/custody/wallets/create"
  Tangany::Custody::WalletsResponsesGenerator.new.create

  puts " -> Regenerating inputs/custody/wallets/update"
  Tangany::Custody::WalletsInputsGenerator.new.update

  puts " -> Regenerating responses/custody/wallets/update"
  Tangany::Custody::WalletsResponsesGenerator.new.update

  puts " -> Regenerating responses/custody/wallets/delete"
  Tangany::Custody::WalletsResponsesGenerator.new.delete
end
