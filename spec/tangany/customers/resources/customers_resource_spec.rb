# frozen_string_literal: true

RSpec.describe(Tangany::Customers::CustomersResource) do
  let(:body) { nil }
  let(:client) { Tangany::Customers::Client.new(adapter: :test, stubs: stubbed_request) }
  let(:method) { :get }
  let(:status) { 200 }
  let(:stubbed_request) do
    stub_customers_request(path, method: method, body: body, response: stubbed_response)
  end
  let(:stubbed_response) { stub_customers_response(fixture: fixture, status: status) }

  context "#create" do
    subject(:customer) { client.customers.create(**body) }

    let(:method) { :post }
    let(:path) { "customers" }

    context "with a valid payload" do
      let(:body) do
        JSON.parse(
          File.read("spec/fixtures/bodies/customers/customers/create/valid-payload.json"),
          symbolize_names: true
        )
      end
      let(:fixture) { "customers/create/created" }

      it "creates a customer" do
        expect(customer).to(be_a(Tangany::Customers::Customer))
      end
    end

    context "with an invalid payload" do
      let(:body) do
        JSON.parse(
          File.read("spec/fixtures/bodies/customers/customers/create/invalid-payload.json"),
          symbolize_names: true
        )
      end
      let(:fixture) { "customers/create/created" }

      it "raises a Dry::Struct::Error" do
        expect { customer }.to(raise_error(Dry::Struct::Error))
      end
    end

    context "with a conflicting payload" do
      let(:body) do
        JSON.parse(
          File.read("spec/fixtures/bodies/customers/customers/create/valid-payload.json"),
          symbolize_names: true
        )
      end
      let(:fixture) { "customers/create/conflicting" }
      let(:status) { 409 }

      it "raises an error" do
        expect { customer }.to(
          raise_error(Tangany::RequestError)
          .with_message(/Customer with ID "[^\"]+" already exists/)
        )
      end
    end
  end

  context "#delete" do
    subject(:customer) { client.customers.delete(customer_id: customer_id) }

    let(:fixture) { "customers/delete/#{customer_id}" }
    let(:method) { :delete }
    let(:path) { "customers/#{customer_id}" }

    context "with a valid customer ID" do
      let(:customer_id) do
        Dir.glob("spec/fixtures/responses/customers/customers/retrieve/*.json").map do |file|
          File.basename(file, ".json")
        end.sample
      end

      it "returns an empty response"
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

    context "with a customer ID assigned to a wallet link" do
      it "raises an error"
      # {
      #     "statusCode": 400,
      #     "activityId": "9b33505c-7255-4b1f-92fa-5bfd8fabcbd6",
      #     "message": "Customer assigned to a wallet link cannot be deleted"
      # }
    end
  end

  context "#list" do
    subject(:customers) { client.customers.list(limit: limit, start: start) }

    let(:fixture) { "customers/list/paginated" }
    let(:limit) { 1 }
    let(:path) { "customers?limit=#{limit}&start=#{start}" }
    let(:start) { 1 }

    it "returns a paginated collection of customers" do
      expect(customers).to(be_a(Tangany::Collection))
      expect(customers.data.first.class).to(eq(Tangany::Customers::Customer))
      expect(customers.total).to(eq(3))
      expect(customers.next_path).to(eq("/customers?start=2&limit=1"))
      expect(customers.previous_path).to(eq("/customers?start=0&limit=1"))
    end
  end

  context "#retrieve" do
    subject(:customer) { client.customers.retrieve(customer_id: customer_id) }

    let(:fixture) { "customers/retrieve/#{customer_id}" }
    let(:path) { "customers/#{customer_id}" }

    context "with a valid customer ID" do
      let(:customer_id) do
        Dir.glob("spec/fixtures/responses/customers/customers/retrieve/*.json").map do |file|
          id = File.basename(file, ".json")
          next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

          id
        end.compact.sample
      end

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
end
