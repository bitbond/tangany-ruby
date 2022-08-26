# frozen_string_literal: true

require "simplecov"
require "simplecov_json_formatter"
require "vcr"

SimpleCov.start do
  if ENV["CI"]
    formatter SimpleCov::Formatter::JSONFormatter
  else
    formatter SimpleCov::Formatter::HTMLFormatter
  end
end

require "tangany"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    Tangany.customers_subscription = ENV.fetch("TEST_TANGANY_SUBSCRIPTION")
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr"
  config.default_cassette_options = { record: :new_episodes }
  config.hook_into(:webmock)
end
