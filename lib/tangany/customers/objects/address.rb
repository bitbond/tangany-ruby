module Tangany
  module Customers
    class Address < Object
      censored :country, :city, :postcode, :streetName, :streetNumber
    end
  end
end
