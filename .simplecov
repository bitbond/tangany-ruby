# frozen_string_literal: true

SimpleCov.configure do
  add_filter "/lib/tangany/version.rb"
  add_filter "/spec/"

  add_group "Customers", "lib/tangany/customers"

  enable_coverage :branch

  track_files "lib/**/*.rb"
end
SimpleCov.minimum_coverage(100.0)
