SimpleCov.configure do
  add_filter "/lib/ruby_critic/"
  add_filter "/lib/simplecov/"
  add_filter "/lib/tangany/version.rb"
  add_filter "/spec/"

  add_group "Core Extensions", "lib/core_ext"
  add_group "Custody", "lib/tangany/custody"
  add_group "Customers", "lib/tangany/customers"

  enable_coverage :branch

  track_files "lib/**/*.rb"
end
SimpleCov.minimum_coverage(100.0)
