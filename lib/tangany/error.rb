# frozen_string_literal: true

module Tangany
  class Error < StandardError; end

  class RequestError < Error
    def initialize(message, activity_id: nil, status_code: nil)
      @activity_id = activity_id
      @status_code = status_code
      super(message)
    end
  end
end
