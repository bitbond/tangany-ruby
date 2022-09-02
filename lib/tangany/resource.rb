# frozen_string_literal: true

module Tangany
  class Resource
    def initialize(client)
      @client = client
    end

    def get_request(url, params: {}, headers: {})
      handle_response(client.connection.get do |request|
        request.url(url)
        request.params = params
        request.headers = default_headers.merge(headers)
      end)
    end

    def post_request(url, body:, headers: {})
      handle_response(client.connection.post do |request|
        request.url(url)
        request.body = body.to_json
        request.headers = default_headers.merge(headers)
      end)
    end

    private

    attr_reader :client

    def default_headers
      { "tangany-subscription" => client.subscription }
    end

    def handle_response(response)
      case response.status
      when 409
        raise RequestError.new(
          response.body[:message],
          activity_id: response.body[:activity_id],
          status_code: response.body[:statusCode]
        )
      else
        response
      end
    end
  end
end
