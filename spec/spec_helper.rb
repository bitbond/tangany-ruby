# frozen_string_literal: true

require "byebug"
require "simplecov"
require "simplecov_json_formatter"
require "webmock/rspec"

SimpleCov.start do
  if ENV["CI"]
    formatter SimpleCov::Formatter::JSONFormatter
  else
    formatter SimpleCov::Formatter::HTMLFormatter
  end
end

require "tangany"
require_relative "support/request_helpers"

RSpec.configure do |config|
  config.before(:suite) do
    Tangany.customers_subscription = ENV.fetch("TEST_TANGANY_SUBSCRIPTION", "test")
  end
  config.disable_monkey_patching!
  config.example_status_persistence_file_path = ".rspec_status"
  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end
  config.expose_dsl_globally = false
  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.order = :random
  config.profile_examples = 10

  config.include(RequestHelpers)

  Kernel.srand(config.seed)
end
