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
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  config.include(RequestHelpers)

  config.before(:suite) do
    Tangany.customers_subscription = ENV.fetch("TEST_TANGANY_SUBSCRIPTION")
  end
end
