# frozen_string_literal: true

module Tangany
  module Customers
    class Customer < Object
      attribute :id, Types::String
      attribute? :person, Person
      attribute? :contract, Contract
      attribute? :additional_attributes, Types::Hash
      attribute? :_links, Types::Hash
    end
  end
end