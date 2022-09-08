# frozen_string_literal: true

module Tangany
  class Error < StandardError; end

  class RequestError < Error
    def initialize(message, activity_id: nil, status_code: nil, validation_errors: [])
      @activity_id = activity_id
      @message = message
      @status_code = status_code
      @validation_errors = validation_errors

      build_message

      super(@message)
    end

    private

    def build_message
      return unless @validation_errors.present?

      @message += " Validation errors: " + @validation_errors.map { |error| "#{error[:source]}: #{error[:message]}" }.join(", ")
    end
  end
end
