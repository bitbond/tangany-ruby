module Tangany
  module Customers
    class Customer < Object
      attribute :id, Types::String
      attribute? :person, Person
      attribute? :contract, Contract
      attribute? :_links, Types::Hash
    end
  end
end
