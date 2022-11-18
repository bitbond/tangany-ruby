module Tangany
  class Config
    attr_accessor :client_id, :client_secret, :ecosystem, :network, :subscription, :vault_url

    attr_reader :custody_base_url, :customers_base_url, :customers_version, :networks

    def initialize
      @custody_base_url = "https://api.tangany.com/v1"

      @customers_base_url = "https://api.tangany.com/customers"
      @customers_version = "1"

      @networks = load_networks
    end

    private

    def load_networks
      JSON.parse(File.read(File.join(__dir__, "../config/networks.json")))
    end
  end
end
