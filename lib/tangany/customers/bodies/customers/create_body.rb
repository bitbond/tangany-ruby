# frozen_string_literal: true

module Tangany
  module Customers
    module Customers
      class CreateBody < Body
        ALLOWED_PERSON_GENDERS = ["F", "M", "X"].freeze
        ALLOWED_PERSON_KYC_DOCUMENT_TYPES = ["id_card", "passport"].freeze
        ALLOWED_PERSON_KYC_METHODS = ["video_ident", "id_copy", "auto_ident", "in_person", "no_verification"].freeze
        COUNTRY_REGEXP = /[A-Z]{2}/.freeze
        DATE_REGEXP = /[0-9]{4}-[0-9]{2}-[0-9]{2}/.freeze
        DATETIME_OPTIONAL_REGEXP = /[0-9]{4}-[0-9]{2}-[0-9]{2}(T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}Z)?/.freeze

        attribute :id, Types::String
        attribute :person do
          attribute :firstName, Types::String.constrained(max_size: 50)
          attribute :lastName, Types::String.constrained(max_size: 50)
          attribute :gender, Types::String.constrained(included_in: ALLOWED_PERSON_GENDERS)
          attribute :birthDate, Types::String.constrained(format: DATE_REGEXP)
          attribute :birthName, Types::String.constrained(max_size: 50)
          attribute :birthPlace, Types::String.constrained(max_size: 50)
          attribute :birthCountry, Types::String.constrained(format: COUNTRY_REGEXP)
          attribute :nationality, Types::String.constrained(format: COUNTRY_REGEXP)
          attribute :address do
            attribute :country, Types::String.constrained(format: COUNTRY_REGEXP)
            attribute :city, Types::String.constrained(max_size: 50)
            attribute :postcode, Types::String.constrained(max_size: 50)
            attribute :streetName, Types::String.constrained(max_size: 50)
            attribute :streetNumber, Types::String.constrained(max_size: 50)
          end
          attribute :email, Types::String.constrained(max_size: 255)
          attribute :kyc do
            attribute :id, Types::String.constrained(max_size: 150)
            attribute :date, Types::String.constrained(format: DATETIME_OPTIONAL_REGEXP)
            attribute :method, Types::String.constrained(included_in: ALLOWED_PERSON_KYC_METHODS)
            attribute :document do
              attribute :country, Types::String.constrained(format: COUNTRY_REGEXP)
              attribute :nationality, Types::String.constrained(format: COUNTRY_REGEXP)
              attribute :number, Types::String.constrained(max_size: 50)
              attribute :issuedBy, Types::String.constrained(max_size: 50)
              attribute :issueDate, Types::String.constrained(format: DATE_REGEXP)
              attribute :validUntil, Types::String.constrained(format: DATE_REGEXP)
              attribute :type, Types::String.constrained(included_in: ALLOWED_PERSON_KYC_DOCUMENT_TYPES)
            end
          end
          attribute :pep do
            attribute :isExposed, Types::Bool
            attribute :checkDate, Types::String.constrained(format: DATE_REGEXP)
            attribute :source, Types::String.constrained(max_size: 255).optional
            attribute :reason?, Types::String.optional
            attribute :isSanctioned?, Types::Bool
          end
        end
        attribute :contract do
          attribute :isSigned, Types::Bool
          attribute :signedDate, Types::String.constrained(format: DATETIME_OPTIONAL_REGEXP).optional
          attribute :isCancelled?, Types::Bool
          attribute :cancelledDate?, Types::String.constrained(format: DATETIME_OPTIONAL_REGEXP).optional
        end
        attribute :additional_attributes, Types::Hash
      end
    end
  end
end
