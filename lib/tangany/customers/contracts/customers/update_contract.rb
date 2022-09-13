# frozen_string_literal: true

module Tangany
  module Customers
    module Customers
      class UpdateContract < Contract
        schema do
          config.validate_keys = true

          required(:id).filled(:string)
          optional(:person).hash do
            optional(:lastName).filled(:string, max_size?: 50)
            optional(:address).hash do
              optional(:country).filled(:string, format?: COUNTRY_REGEXP)
              optional(:city).filled(:string, max_size?: 50)
              optional(:postcode).filled(:string, max_size?: 50)
              optional(:streetName).filled(:string, max_size?: 50)
              optional(:streetNumber).filled(:string, max_size?: 50)
            end
            optional(:email).filled(:string, max_size?: 255)
            optional(:pep).hash do
              optional(:isExposed).filled(:bool)
              optional(:checkDate).filled(:string, format?: DATE_REGEXP)
              optional(:source).maybe(:string, max_size?: 255)
              optional(:reason).maybe(:string)
              optional(:isSanctioned).filled(:bool)
            end
          end
          optional(:contract).hash do
            optional(:isSigned).filled(:bool)
            optional(:signedDate).filled(:string, format?: DATETIME_OPTIONAL_REGEXP) # can also be nil
            optional(:isCancelled).filled(:bool)
            optional(:cancelledDate).filled(:string, format?: DATETIME_OPTIONAL_REGEXP) # can also be nil
          end
          optional(:additionalAttributes).filled(:hash)
        end
      end
    end
  end
end
