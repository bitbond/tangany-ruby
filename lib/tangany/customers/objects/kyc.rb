module Tangany
  module Customers
    class Kyc < Object
      ALLOWED_DOCUMENT_TYPES = ["id_card", "passport"].freeze
      ALLOWED_METHODS = ["video_ident", "id_copy", "auto_ident", "in_person", "no_verification"].freeze

      attribute :id, Types::String
      attribute :date, Types::DateTime
      attribute :method, Types::String
      attribute :document, Document

      to_datetime :date
    end
  end
end
