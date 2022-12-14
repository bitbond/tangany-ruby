require_relative "lib/tangany/version"

Gem::Specification.new do |spec|
  spec.name = "tangany"
  spec.version = Tangany::VERSION
  spec.required_ruby_version = ">= 2.7.5"
  spec.summary = "Ruby bindings for the Tangany APIs"
  spec.description = "Tangany is a German provider for custody of digital assets and crypto. See https://tangany.com/ for details."
  spec.author = "Bitbond"
  spec.email = "service@bitbond.com"
  spec.homepage = "https://github.com/bitbond/tangany-ruby"
  spec.license = "MIT"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bitbond/tangany-ruby/issues",
    "changelog_uri" => "https://github.com/bitbond/tangany-ruby/blob/master/CHANGELOG.md",
    "documentation_uri" => spec.homepage,
    "github_repo" => "ssh://github.com/bitbond/tangany-ruby",
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/bitbond/tangany-ruby"
  }

  ignored = Regexp.union(
    /\A\.git/,
    /\A\.rubocop/,
    /\A\.travis.yml/,
    /\A\.vscode/,
    /\Aspec/
  )
  spec.files = `git ls-files -z`.split("\x0").reject { |f| (f == __FILE__) || ignored.match(f) }
  spec.executables = `git ls-files -z -- bin/*`.split("\x0").map { |f| ::File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("activesupport", ">=6.0", "< 8.0.0")
  spec.add_dependency("dry-struct", ">= 1.6", "< 2.0.0")
  spec.add_dependency("dry-validation", ">= 1.10", "< 2.0.0")
  spec.add_dependency("faraday", ">= 2.7", "< 2.8.0")
end
