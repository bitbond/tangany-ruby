# frozen_string_literal: true

module Tangany
  module Customers
    class WalletLink < Object
      attribute :id, Types::String
      attribute? :type, Types::String
      attribute? :assignment, Types::Hash
    end
  end
end
