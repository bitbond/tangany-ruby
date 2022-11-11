# Tangany Ruby Library

[![CI](https://github.com/bitbond/tangany-ruby/actions/workflows/ci.yml/badge.svg)](https://github.com/bitbond/tangany-ruby/actions/workflows/ci.yml)

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

The library needs to be configured with your account's secrets.

### Customers API

```ruby
require 'tangany'
Tangany.subscription = '...'

# initialize the client
customers_client = Tangany::Customers::Client.new

# list customers
collection = customers_client.customers.list(limit: 21, sort: 'asc', start: 42)

# retrieve single customer
customer = customers_client.customers.retrieve('cus_123456789')

# create customer
customer = customers_client.customers.create(
  id: 'cus_123456789',
  person: {
    firstName: 'John',
    lastName: 'Doe',
    ...
  },
  ...
)

# update customer
customer = customers_client.customers.update(
  'cus_123456789',
  person: {
    firstName: 'John',
    lastName: 'Doe',
    ...
  },
  ...
)

# delete customer
response = customers_client.customers.delete('cus_123456789')

# list wallet links
collection = customers_client.wallet_links.list(limit: 21, sort: 'asc', start: 42)

# retrieve single wallet link
wallet_link = customers_client.wallet_links.retrieve('wl_123456789')

# create wallet link
wallet_link = customers_client.wallet_links.create(
  id: 'wl_123456789',
  type: 'waas',
  vaultUrl: 'https://vault.example.com',
  vaultWalletId: 'wal_123456789',
  assignment: {
    customerId: 'cus_123456789',
  }
)
```

### Custody API

```ruby
require 'tangany'
Tangany.client_id = '...'
Tangany.client_secret = '...'
Tangany.subscription = '...'
Tangany.vault_url = '...'

# initialize the client
custody_client = Tangany::Custody::Client.new

# list wallets
collection = custody_client.wallets.list(limit: 21, order: 'wallet', sort: 'asc', start: 42, tags: { tag0: 'tag 0', tag1: 'tag 1' }, xtags: { tag2: 'tag 2', tag3: 'tag 3' })

# retrieve single wallet
wallet = custody_client.wallets.retrieve('wal_123456789')

# create wallet
wallet = custody_client.wallets.create(
  wallet: 'wal_123456789',
  useHsm: false,
  tags: [{
    tag0: 'tag 0'
  }, {
    tag1: 'tag 1',
  }, {
    ...
  }, {
    tag9: 'tag 9'
  }]
)

# update wallet
wallet = custody_client.wallets.update(
  'wal_123456789',
  tags: [{
    tag0: 'tag 0'
  }, {
    tag1: 'tag 1',
  }, {
    ...
  }, {
    tag9: 'tag 9'
  }]
)

# delete customer
wallet_recovery = custody_client.customers.delete('wal_123456789')
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

If Tangany API changes, edit the `spec/factories` and the `spec/generators` accordingly, then run all tests:

```sh
rspec
```

Fixtures will be regenerated automatically each time you run the tests.

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
