# frozen_string_literal: true

require "byebug"
require "bundler/gem_tasks"
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

  # Customers

  puts " -> Regenerating responses/customers/customers/retrieve"
  Tangany::Customers::CustomersResponsesGenerator.new.retrieve

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

  # Wallet links

  puts " -> Regenerating responses/customers/wallet_links/retrieve"
  Tangany::Customers::WalletLinksResponsesGenerator.new.retrieve

  puts " -> Regenerating responses/customers/wallet_links/list"
  Tangany::Customers::WalletLinksResponsesGenerator.new.list
end
