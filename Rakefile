# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: [:spec, :rubocop]

namespace :code do
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
end
