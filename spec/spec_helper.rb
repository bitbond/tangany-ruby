require "byebug"
require "factory_bot"
require "rake"
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
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    # FactoryBot.find_definitions

    load("Rakefile")
    Rake::Task["regenerate_fixtures"].invoke
    Tangany.client_id = ENV.fetch("TEST_TANGANY_CLIENT_ID", "test")
    Tangany.client_secret = ENV.fetch("TEST_TANGANY_CLIENT_SECRET", "test")
    Tangany.subscription = ENV.fetch("TEST_TANGANY_SUBSCRIPTION", "test")
    Tangany.vault_url = ENV.fetch("TEST_TANGANY_VAULT_URL", "test")
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
