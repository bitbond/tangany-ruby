require "forwardable"

require_relative "tangany/config"

module Tangany
  @config = Config.new

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :config,
      :client_id,
      :client_id=,
      :client_secret,
      :client_secret=,
      :custody_base_url,
      :customers_base_url,
      :customers_version,
      :environment,
      :environment=,
      :protocol,
      :protocol=,
      :protocols,
      :subscription,
      :subscription=,
      :vault_url,
      :vault_url=
  end
end

require_relative "tangany/error"
require_relative "tangany/json_patch"

require_relative "tangany/collection"
require_relative "tangany/resource"
require_relative "tangany/types"
require_relative "tangany/version"

require_relative "tangany/application_contract"

require_relative "tangany/object"
require_relative "tangany/operation"

require_relative "tangany/custody"
require_relative "tangany/customers"
