# frozen_string_literal: true

module Tangany
  module Customers
    class Kyc < Object
      ALLOWED_METHODS = ["video_ident", "id_copy", "auto_ident", "in_person", "no_verification"].freeze

      attribute :id, Types::String.constrained(max_size: 150)
      attribute :date, Types::String.constrained(format: DATETIME_OPTIONAL_REGEXP)
      attribute :method, Types::String.constrained(included_in: ALLOWED_METHODS)
      attribute :document, Document
    end
  end
end
