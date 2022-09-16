module Tangany
  class Config
    attr_accessor :client_id, :client_secret, :subscription, :vault_url

    attr_reader :custody_base_url, :customers_base_url, :customers_version

    def initialize
      @custody_base_url = "https://api.tangany.com/v1"

      @customers_base_url = "https://api.tangany.com/customers"
      @customers_version = "1"
    end
  end
end
