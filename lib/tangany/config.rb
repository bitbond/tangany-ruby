require "json"

module Tangany
  class Config
    attr_accessor :client_id, :client_secret, :environment, :chain, :subscription, :vault_url

    attr_reader :custody_base_url, :customers_base_url, :customers_version, :chains

    def initialize
      @custody_base_url = "https://api.tangany.com/v1"

      @customers_base_url = "https://api.tangany.com/customers"
      @customers_version = "1"

      @chains = load_chains
    end

    private

    def load_chains
      JSON.parse(File.read(File.join(__dir__, "../config/chains.json")))
    end
  end
end
