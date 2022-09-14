module Tangany
  class Resource
    def initialize(client)
      @client = client
    end

    def delete_request(url, headers: {})
      handle_response(client.connection.delete do |request|
        request.url(url)
        request.headers = default_headers.merge(headers)
      end)
    end

    def get_request(url, params: {}, headers: {})
      handle_response(client.connection.get do |request|
        request.url(url)
        request.params = params
        request.headers = default_headers.merge(headers)
      end)
    end

    def patch_request(url, body:, headers: {})
      handle_response(client.connection.patch do |request|
        request.url(url)
        request.body = body
        request.headers = default_headers.merge({"Content-Type" => "application/json-patch+json"}.merge(headers))
      end)
    end

    def post_request(url, body:, headers: {})
      handle_response(client.connection.post do |request|
        request.url(url)
        request.body = body
        request.headers = default_headers.merge(headers)
      end)
    end

    private

    attr_reader :client

    def default_headers
      {"tangany-subscription" => client.subscription}
    end

    def handle_response(response)
      case response.status
      when 400, 404, 409
        raise RequestError.new(
          response.body[:message],
          activity_id: response.headers["tangany-activity-id"],
          status_code: response.body[:statusCode],
          validation_errors: response.body[:validationErrors]
        )
      when 412
        raise RequestError.new(
          "Mid-air edit collision detected",
          activity_id: response.headers["tangany-activity-id"],
          status_code: 412
        )
      else
        response
      end
    end
  end
end
