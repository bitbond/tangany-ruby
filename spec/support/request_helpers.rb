# frozen_string_literal: true

module RequestHelpers
  def stub_customers_response(fixture:, status: 200, headers: { "Content-Type" => "application/json" })
    [status, headers, File.read("spec/fixtures/responses/customers/#{fixture}.json")]
  end

  def stub_customers_request(path, response:, method: :get, body: {})
    Faraday::Adapter::Test::Stubs.new do |stub|
      arguments = [method, "/customers/#{path}"]
      arguments << body.to_json if [:post, :put, :patch].include?(method)
      stub.send(*arguments) { |_env| response }
    end
  end
end
