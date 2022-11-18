require_relative "document"

module Tangany
  module Customers
    class Kyc < Object
      ALLOWED_METHODS = %w[video_ident id_copy auto_ident in_person].freeze

      attribute :id, Types::String
      attribute :date, Types::DateTime
      attribute :method, Types::String
      attribute? :document, Document

      to_datetime :date
    end
  end
end
