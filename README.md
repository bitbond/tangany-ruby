# Tangany Ruby Library

[![Gem Version](https://badge.fury.io/rb/tangany.svg)](https://badge.fury.io/rb/tangany)
[![CI](https://github.com/bitbond/tangany-ruby/actions/workflows/ci.yml/badge.svg)](https://github.com/bitbond/tangany-ruby/actions/workflows/ci.yml)
![coverage](https://img.shields.io/badge/coverage-97%25-green)

The Tangany Ruby library provides convenient access to the Tangany APIs from applications written in the Ruby language. It includes a pre-defined set of classes for API resources that initialize themselves dynamically from API responses.

---

## Documentation

See the [API docs](https://docs.tangany.com) for more details.

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
source "https://rubygems.org"

gem "tangany"
```

---

## Usage

The library needs to be configured with your account's secrets.

```ruby
require "tangany"
Tangany.client_id = "..."
Tangany.client_secret = "..."
Tangany.environment = "..." # mainnet or testnet
Tangany.subscription = "..."
Tangany.vault_url = "..."

customers_client = Tangany::Customers::Client.new
custody_client = Tangany::Custody::Client.new
```

---

## Customers API

### Natural persons

#### List natural_persons

```ruby
collection = customers_client.natural_persons.list(limit: 21, sort: "asc", pageToken: "foo")
```

#### Create natural person

```ruby
natural_person = customers_client.natural_persons.create(
  id: "ent_123456789",
  title: "Mr",
  firstName: "John",
  lastName: "Doe",
  gender: "M",
  birthDate: "1980-01-01",
  birthPlace: "Milano",
  birthCountry: "IT",
  birthName: "John",
  nationality: "IT",
  address: {
    country: "IT",
    city: "Milano",
    postcode: "20100",
    streetName: "Via Roma",
    streetNumber: "1",
  },
  email: "john.doe@example.com",
  kyc: {
    id: "kyc_123456789",
    date: "2021-01-01T00:00:00.000Z",
    method: "video_ident",
    document: {
      country: "IT",
      nationality: "IT",
      number: "123456789",
      issuedBy: "Milano",
      issueDate: "2015-01-01",
      validUntil: "2025-01-01",
      type: "id_card"
    }
  },
  pep: {
    checkDate: "2021-01-01T00:00:00.000Z",
    isExposed: true,
    source: "PEP source",
    reason: "PEP reason"
  },
  sanctions: {
    checkDate: "2021-01-01T00:00:00.000Z",
    isExposed: true,
    source: "Sanctions source",
    reason: "Sanctions reason"
  }
)
```

#### Retrieve natural person

```ruby
customer = customers_client.natural_persons.retrieve("ent_123456789")
```

#### Update natural person

```ruby
natural_person = customers_client.natural_persons.update(
  "ent_123456789",
  title: "Mr",
  firstName: "John",
  lastName: "Doe",
  gender: "M",
  birthDate: "1980-01-01",
  birthPlace: "Milano",
  birthCountry: "IT",
  birthName: "John",
  nationality: "IT",
  address: {
    country: "IT",
    city: "Milano",
    postcode: "20100",
    streetName: "Via Roma",
    streetNumber: "1",
  },
  email: "john.doe@example.com",
  kyc: {
    id: "kyc_123456789",
    date: "2021-01-01T00:00:00.000Z",
    method: "video_ident",
    document: {
      country: "IT",
      nationality: "IT",
      number: "123456789",
      issuedBy: "Milano",
      issueDate: "2015-01-01",
      validUntil: "2025-01-01",
      type: "id_card"
    }
  },
  pep: {
    checkDate: "2021-01-01T00:00:00.000Z",
    isExposed: true,
    source: "PEP source",
    reason: "PEP reason"
  },
  sanctions: {
    checkDate: "2021-01-01T00:00:00.000Z",
    isExposed: true,
    source: "Sanctions source",
    reason: "Sanctions reason"
  }
)
```

#### Delete natural person

```ruby
response = customers_client.natural_persons.delete("ent_123456789")
```

### Customers

#### List customers

```ruby
collection = customers_client.customers.list(limit: 21, sort: "asc", pageToken: "foo")
```

#### Create customer

```ruby
customer = customers_client.customers.create(
  id: "cus_123456789",
  owner: {
    entityId: "ent_123456789",
  },
  authorized: {
    entityId: "ent_123456789",
  },
  contracts: [{
    type: "standard",
    signedDate: "2020-09-04",
  }]
)
```

#### Retrieve customer

```ruby
customer = customers_client.customers.retrieve("cus_123456789")
```

#### Update customer

```ruby
customer = customers_client.customers.update(
  "cus_123456789",
  owner: {
    entityId: "ent_123456789",
  },
  authorized: {
    entityId: "ent_123456789",
  },
  contracts: [{
    type: "standard",
    signedDate: "2020-09-04",
  }]
)
```

#### Delete customer

```ruby
response = customers_client.customers.delete("cus_123456789")
```

### Wallet links

#### List wallet links

```ruby
collection = customers_client.wallet_links.list(limit: 21, sort: "asc", pageToken: "foo")
```

#### Create wallet link

With an address:

```ruby
wallet_link = customers_client.wallet_links.create(
  id: "wl_123456789",
  address: "0x1234567890abcdef1234567890abcdef12345678",
  assetId: "ETH",
  assignment: {
    customerId: "cus_123456789",
  }
)
```

With a wallet:

```ruby
wallet_link = customers_client.wallet_links.create(
  id: "wl_123456789",
  wallet: "wal_123456789",
  assetId: "ETH",
  assignment: {
    customerId: "cus_123456789",
  }
)
```

#### Retrieve wallet link

```ruby
wallet_link = customers_client.wallet_links.retrieve("wl_123456789")
```

#### Delete wallet link

```ruby
response = customers_client.wallet_links.delete("wl_123456789")
```

---

## Custody API

See [lib/config/chains.json](lib/config/chains.json) for the list of available chains.

### Wallets

#### List wallets

```ruby
collection = custody_client.wallets.list(limit: 21, order: "wallet", sort: "asc", start: 42, tags: { tag0: "tag 0", tag1: "tag 1" }, xtags: { tag2: "tag 2", tag3: "tag 3" })
```

#### Create wallet

```ruby
wallet = custody_client.wallets.create(
  wallet: "wal_123456789",
  useHsm: false,
  tags: [{
    tag0: "tag 0"
  }, {
    tag1: "tag 1",
  }, {
    ...
  }, {
    tag9: "tag 9"
  }]
)
```

#### Retrieve wallet

```ruby
wallet = custody_client.wallets.retrieve("wal_123456789")
```

#### Update wallet

```ruby
wallet = custody_client.wallets.update(
  "wal_123456789",
  tags: [{
    tag0: "tag 0"
  }, {
    tag1: "tag 1",
  }, {
    ...
  }, {
    tag9: "tag 9"
  }]
)
```

#### Delete wallet

```ruby
wallet_recovery = custody_client.customers.delete("wal_123456789")
```

### Wallet statuses

#### Retrieve wallet status

```ruby
wallet_status = custody_client.wallet_statuses(assetId: "ETH").retrieve("wal_123456789")
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

It is also possible to run a test suite against the live API.

> :warning: Be sure to set environment variables **not to production values** before running the following command!

```sh
bin/test-live
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
