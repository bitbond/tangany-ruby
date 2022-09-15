module RequestHelpers
  def stub_custody_response(fixture:, status: 200, headers: {})
    [status, default_headers.merge(headers), File.read("spec/fixtures/generated/responses/custody/#{fixture}.json")]
  end

  def stub_custody_request(stubs, path, response:, method: :get, body: "{}")
    arguments = [method, "/custody/#{path}"]
    arguments << body if [:post, :put, :patch].include?(method)
    stubs.send(*arguments) { |_env| response }
  end

  def stub_customers_response(fixture:, status: 200, headers: {})
    [status, default_headers.merge(headers), File.read("spec/fixtures/generated/responses/customers/#{fixture}.json")]
  end

  def stub_customers_request(stubs, path, response:, method: :get, body: "{}")
    arguments = [method, "/customers/#{path}"]
    arguments << body if [:post, :put, :patch].include?(method)
    stubs.send(*arguments) { |_env| response }
  end

  private

  def default_headers
    {"Content-Type" => "application/json"}
  end
end
