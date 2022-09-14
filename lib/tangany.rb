require "forwardable"
require "hash_diff"

require_relative "core_ext/hash_diff/comparison"

require_relative "tangany/error"

require_relative "tangany/collection"
require_relative "tangany/config"
require_relative "tangany/resource"
require_relative "tangany/types"
require_relative "tangany/version"

require_relative "tangany/contract"

require_relative "tangany/object"
require_relative "tangany/operation"

require_relative "tangany/customers"

module Tangany
  @config = Config.new

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :config,
      :customers_base_url,
      :subscription,
      :subscription=,
      :customers_version
  end
end
