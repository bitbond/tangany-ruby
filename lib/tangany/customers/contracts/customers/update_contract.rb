module Tangany
  module Customers
    module Customers
      class UpdateContract < Contract
        AdditionalAttributesSchema = Dry::Schema.Params do
          optional(:foo) # FIXME: required to have a valid "empty" schema
        end

        AddressSchema = Dry::Schema.Params do
          optional(:country).filled(:string, format?: COUNTRY_REGEXP)
          optional(:city).filled(:string, max_size?: 50)
          optional(:postcode).filled(:string, max_size?: 50)
          optional(:streetName).filled(:string, max_size?: 50)
          optional(:streetNumber).filled(:string, max_size?: 50)
        end

        ContractSchema = Dry::Schema.Params do
          optional(:isSigned).filled(:bool)
          optional(:signedDate).filled(:string, format?: DATETIME_OPTIONAL_REGEXP) # can also be nil
          optional(:isCancelled).filled(:bool)
          optional(:cancelledDate).filled(:string, format?: DATETIME_OPTIONAL_REGEXP) # can also be nil
        end

        PepSchema = Dry::Schema.Params do
          optional(:isExposed).filled(:bool)
          optional(:checkDate).filled(:string, format?: DATE_REGEXP)
          optional(:source).maybe(:string, max_size?: 255)
          optional(:reason).maybe(:string)
          optional(:isSanctioned).filled(:bool)
        end

        PersonSchema = Dry::Schema.Params do
          optional(:lastName).filled(:string, max_size?: 50)
          optional(:address).hash(AddressSchema)
          optional(:email).filled(:string, max_size?: 255)
          optional(:pep).hash(PepSchema)
        end

        schema do
          config.validate_keys = true

          required(:id).filled(:string)
          optional(:person).hash(PersonSchema)
          optional(:contract).hash(ContractSchema)
          optional(:additionalAttributes).hash(AdditionalAttributesSchema)
        end
      end
    end
  end
end
