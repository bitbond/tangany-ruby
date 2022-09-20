RSpec.describe(Tangany::Customers::CustomersResource) do
  let(:body) { "{}" }
  let(:client) { Tangany::Customers::Client.new(adapter: :test, stubs: stubs) }
  let(:method) { :get }
  let(:status) { 200 }
  let(:stubbed_response) { stub_customers_response(fixture: fixture, status: status) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }

  before do
    stub_customers_request(stubs, path, method: method, body: body, response: stubbed_response)
  end

  describe "#create" do
    subject(:customer) { client.customers.create(**input) }

    let(:body) { input.to_json }
    let(:method) { :post }
    let(:path) { "customers" }

    context "with a valid payload" do
      let(:input) do
        JSON.parse(
          File.read("spec/fixtures/generated/inputs/customers/customers/create/valid_input.json"),
          symbolize_names: true
        )
      end
      let(:fixture) { "customers/create/created" }

      it "creates a customer" do
        expect(customer).to(be_a(Tangany::Customers::Customer))
      end
    end

    context "with an invalid payload" do
      let(:input) { {foo: :bar} }
      let(:fixture) { "customers/create/created" }

      it "raises a Dry::Struct::Error" do
        expect { customer }.to(raise_error(Tangany::InputError).with_message(/"foo":\["is not allowed"\]/))
      end
    end

    context "with a conflicting payload" do
      let(:input) do
        JSON.parse(
          File.read("spec/fixtures/generated/inputs/customers/customers/create/valid_input.json"),
          symbolize_names: true
        )
      end
      let(:fixture) { "customers/create/conflicting" }
      let(:status) { 409 }

      it "raises an error" do
        expect { customer }.to(
          raise_error(Tangany::RequestError)
          .with_message(/Customer with ID "[^"]+" already exists/)
        )
      end
    end
  end

  describe "#delete" do
    subject(:customer) { client.customers.delete(customer_id) }

    let(:fixture) { "customers/delete/#{customer_id}" }
    let(:method) { :delete }
    let(:path) { "customers/#{customer_id}" }

    context "with a valid customer ID" do
      let(:customer_id) { fetch_customer_id }

      it "returns an empty response" do
        expect { customer }.not_to(raise_error)
      end
    end

    context "with an invalid customer ID" do
      let(:customer_id) { "not_found" }
      let(:status) { 404 }

      it "raises an error" do
        expect { customer }.to(
          raise_error(Tangany::RequestError)
          .with_message("Customer with ID \"#{customer_id}\" was not found")
        )
      end
    end
  end

  describe "#list" do
    subject(:customers) { client.customers.list(limit: limit, sort: sort, start: start) }

    let(:fixture) { "customers/list/paginated" }
    let(:limit) { 1 }
    let(:path) { "customers?limit=#{limit}&sort=#{sort}&start=#{start}" }
    let(:start) { 1 }
    let(:sort) { "asc" }

    it "returns a collection" do
      expect(customers).to(be_a(Tangany::Collection))
    end

    it "returns a collection of customers" do
      expect(customers.data.first.class).to(eq(Tangany::Customers::Customer))
    end

    it "has a total of 3" do
      expect(customers.total).to(eq(3))
    end

    it "has a next path" do
      expect(customers.next_path).to(eq("/customers?start=2&limit=1&sort=#{sort}"))
    end

    it "has a previous path" do
      expect(customers.previous_path).to(eq("/customers?start=0&limit=1&sort=#{sort}"))
    end
  end

  describe "#retrieve" do
    subject(:customer) { client.customers.retrieve(customer_id) }

    let(:fixture) { "customers/retrieve/#{customer_id}" }
    let(:path) { "customers/#{customer_id}" }

    context "with a valid customer ID" do
      let(:customer_id) { fetch_customer_id }

      it "returns a Customer" do
        expect(customer).to(be_a(Tangany::Customers::Customer))
      end
    end

    context "with an invalid customer ID" do
      let(:customer_id) { "not_found" }
      let(:status) { 404 }

      it "raises an error" do
        expect { customer }.to(
          raise_error(Tangany::RequestError)
          .with_message("Customer with ID \"#{customer_id}\" was not found")
        )
      end
    end

    context "with a deleted customer ID" do
      let(:customer_id) { "deleted" }
      let(:status) { 404 }

      it "raises an error" do
        expect { customer }.to(
          raise_error(Tangany::RequestError)
          .with_message("Customer with ID \"#{customer_id}\" has been deleted")
        )
      end
    end
  end

  describe "#update" do
    subject(:customer) { client.customers.update(customer_id, **params) }

    let(:fixture) { "customers/update/#{customer_id}" }
    let(:if_match_header) { "etag" }
    let(:method) { :patch }
    let(:params) { {} }
    let(:path) { "customers/#{customer_id}" }

    before do
      stub_customers_request(
        stubs,
        path,
        method: :get,
        response: stub_customers_response(
          fixture: "customers/retrieve/#{customer_id}",
          headers: {"If-Match" => if_match_header},
          status: status
        )
      )
    end

    context "with a valid customer ID" do
      let(:customer_id) { fetch_customer_id }
      let(:fixture) { "customers/update/updated" }

      context "with a valid payload" do
        let(:body) do
          customer_hash = Tangany::Customers::Customer.new(JSON.parse(
            File.read("spec/fixtures/generated/responses/customers/customers/retrieve/#{customer_id}.json"),
            symbolize_names: true
          )).to_h
          safe_params = Tangany::Customers::Customers::UpdateContract.new.to_safe_params!(params)
          merged_hash = customer_hash.deep_merge(safe_params)
          Tangany::JsonPatch.new(customer_hash, merged_hash).generate.to_json
        end
        let(:params) do
          JSON.parse(
            File.read("spec/fixtures/generated/inputs/customers/customers/update/valid_input.json"),
            symbolize_names: true
          )
        end

        it "updates the customer" do
          expect(customer).to(be_a(Tangany::Customers::Customer))
        end
      end

      context "with an invalid payload" do
        let(:params) { {foo: :bar} }

        it "raises a Dry::Struct::Error" do
          expect { customer }.to(raise_error(Tangany::InputError).with_message(/"foo":\["is not allowed"\]/))
        end
      end

      context "with a conflicting If-Match precondition" do
        let(:status) { 412 }

        it "raises an error" do
          expect { customer }.to(
            raise_error(Tangany::RequestError)
            .with_message("Mid-air edit collision detected")
          )
        end
      end
    end

    context "with an invalid customer ID" do
      let(:customer_id) { "not_found" }
      let(:status) { 404 }

      it "raises an error" do
        expect { customer }.to(
          raise_error(Tangany::RequestError)
          .with_message("Customer with ID \"#{customer_id}\" was not found")
        )
      end
    end
  end

  private

  def fetch_customer_id
    Dir.glob("spec/fixtures/generated/responses/customers/customers/retrieve/*.json").map do |file|
      id = File.basename(file, ".json")
      next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

      id
    end.compact.min
  end
end
