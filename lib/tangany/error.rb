module Tangany
  class Error < StandardError; end

  class InputError < Error
    def initialize(validation_errors)
      super(validation_errors.to_json)
    end
  end

  class RequestError < Error
    def initialize(message, activity_id: nil, status_code: nil, validation_errors: [])
      @activity_id = activity_id
      @message = message
      @status_code = status_code
      @validation_errors = validation_errors

      build_message if @validation_errors.present?

      super(@message)
    end

    private

    def build_message
      @message += " Validation errors: " + @validation_errors.map { |error| "#{error[:source]}: #{error[:message]}" }.join(", ")
    end
  end
end
