# frozen_string_literal: true

module Tangany
  class Input < Dry::Struct
    COUNTRY_REGEXP = /[A-Z]{2}/.freeze
    DATE_REGEXP = /[0-9]{4}-[0-9]{2}-[0-9]{2}/.freeze
    DATETIME_OPTIONAL_REGEXP = /[0-9]{4}-[0-9]{2}-[0-9]{2}(T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}Z)?/.freeze

    schema schema.strict

    def to_json
      to_h.to_json
    end
  end
end
