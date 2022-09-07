# frozen_string_literal: true

module Tangany
  class Input < Dry::Struct
    COUNTRY_REGEXP = %r{[A-Z]{2}}
    DATE_REGEXP = %r{[0-9]{4}-[0-9]{2}-[0-9]{2}}
    DATETIME_OPTIONAL_REGEXP = %r{[0-9]{4}-[0-9]{2}-[0-9]{2}(T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}Z)?}

    schema schema.strict

    def to_json
      to_h.to_json
    end
  end
end
