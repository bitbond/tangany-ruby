# Tangany Ruby Library

The Tangany Ruby library provides convenient access to the Tangany APIs from applications written in the Ruby language. It includes a pre-defined set of classes for API resources that initialize themselves dynamically from API responses.

---

## Installation

You don't need this source code unless you want to modify the gem. If you just want to use the package, just run:

```sh
gem install tangany
```

If you want to build the gem from source:

```sh
gem build tangany.gemspec
```

### Requirements

- Ruby 2.7.5+.

### Bundler

If you are installing via bundler, you should be sure to use the https rubygems source in your Gemfile, as any gems fetched over http could potentially be compromised in transit and alter the code of gems fetched securely over https:

```ruby
source 'https://rubygems.org'

gem 'tangany'
```

---

## Usage

The library needs to be configured with your account's secrets. Set `Tangany.customers_subscription` to its value:

```ruby
require 'tangany'
Tangany.customers_subscription = '...'

# initialize the client
customers_client = Tangany::Customers::client.new

# list customers
customers_client.customers.list(limit: 21, start: 42)

# retrieve single customer
customers_client.customers.retrieve('cus_123456789')

# create customer
customers_client.customers.create(
  id: 'cus_123456789',
  person: {
    firstName: 'John',
    lastName: 'Doe',
    ...
  },
  ...
)
```

---

## Development

### Git config

Tell `git` where to find the project shared hooks:

```bash
git config core.hooksPath .githooks
```

### Interactive console

```sh
bin/console
```

### Testing

If Tangany API changes, edit the `spec/factories` and the `spec/generators` accordingly, then regenerate all the fixtures:

```sh
rake regenerate_fixtures
```

Run all tests:

```sh
rspec
```

Run a single test suite:

```sh
rspec spec/tangany/customers/client_spec.rb
```

### Linting and code quality

Run the linter:

```sh
rubocop
```

Run the code quality checker:

```sh
rake quality_check
```

---

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bitbond/tangany-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/bitbond/tangany-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tangany::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bitbond/tangany-ruby/blob/main/CODE_OF_CONDUCT.md).
