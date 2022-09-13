# frozen_string_literal: true

require "dry-validation"

module Tangany
  class Contract < Dry::Validation::Contract
    COUNTRY_REGEXP = %r{[A-Z]{2}}
    DATE_REGEXP = %r{[0-9]{4}-[0-9]{2}-[0-9]{2}}
    DATETIME_OPTIONAL_REGEXP = %r{[0-9]{4}-[0-9]{2}-[0-9]{2}(T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}Z)?}

    def call!(params)
      response = call(params)
      raise InputError, response.errors.to_h if response.failure?

      response
    end
  end
end
