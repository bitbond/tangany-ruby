# frozen_string_literal: true

require "forwardable"

require_relative "tangany/config"
require_relative "tangany/error"
require_relative "tangany/version"

require_relative "tangany/customers"

module Tangany
  @config = Config.new

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :config,
      :customers_base_url,
      :customers_subscription,
      :customers_subscription=,
      :customers_version
  end
end
