# frozen_string_literal: true

require "byebug"
require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

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
  puts "== Regenerating customers responses ".ljust(80, "=")

  puts " -> Regenerating customers/retrieve"
  Tangany::Customers::CustomersResponsesGenerator.new.retrieve

  puts " -> Regenerating customers/list"
  Tangany::Customers::CustomersResponsesGenerator.new.list

  puts " -> Regenerating customers/create"
  Tangany::Customers::CustomersResponsesGenerator.new.create

  # puts " -> Regenerating customers/list"
  # # Dir.glob("spec/fixtures/responses/customers/customers/list/*.json").each { |file| File.delete(file) }
  # customers = {}
  # response = {
  #   total: customers.size,
  #   results: customers.values.map { |value| value["id"] },
  #   _links: {
  #     next: nil,
  #     previous: nil,
  #   },
  # }
  # File.open("spec/fixtures/responses/customers/customers/list/empty.json", "w") do |file|
  #   file.write(JSON.pretty_generate(response))
  # end
end

task default: [:rubocop, :quality_check, :spec]
