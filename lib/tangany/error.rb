module Tangany
  class Error < StandardError; end

  class InputError < Error
    def initialize(validation_errors)
      super(validation_errors.to_json)
    end
  end

  class RequestError < Error
    attr_reader :activity_id, :details, :error_code, :status_code, :validation_errors

    def initialize(message, activity_id: nil, details: nil, error_code: nil, status_code: nil, validation_errors: [])
      @activity_id = activity_id
      @details = details
      @error_code = error_code
      @message = message
      @status_code = status_code
      @validation_errors = validation_errors

      enrich_message

      super(@message)
    end

    private

    def enrich_message
      @message = "[#{status_code}] #{@message}"
      @message += " (#{details})" if details
      @message += " Validation errors: " + validation_errors.map { |error| "#{error[:source]}: #{error[:message]}" }.join(", ") if validation_errors&.any?
    end
  end
end
