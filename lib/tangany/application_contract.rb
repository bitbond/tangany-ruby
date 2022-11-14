require "active_support/core_ext/object/to_param"
require "dry-validation"

module Tangany
  class ApplicationContract < Dry::Validation::Contract
    ALLOWED_SORTS = ["asc", "desc"].freeze
    COUNTRY_CODE_REGEX = %r{[A-Z]{2}}
    DATE_REGEX = %r{[0-9]{4}-[0-9]{2}-[0-9]{2}}
    DATETIME_REGEX = %r{[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}Z}

    def to_safe_params!(params)
      response = call(params)
      raise InputError, response.errors.to_h if response.failure?

      response.to_h
    end
  end
end
