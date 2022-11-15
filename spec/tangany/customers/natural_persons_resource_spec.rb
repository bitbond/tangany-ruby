RSpec.describe(Tangany::Customers::NaturalPersonsResource) do
  let(:body) { "{}" }
  let(:client) { Tangany::Customers::Client.new(adapter: :test, stubs: stubs) }
  let(:method) { :get }
  let(:status) { 200 }
  let(:stubbed_response) { stub_customers_response(fixture: fixture, status: status) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }

  before { stub_customers_request(stubs, path, method: method, body: body, response: stubbed_response) }

  describe "#create" do
    subject(:natural_person) { client.natural_persons.create(**input) }

    let(:body) { input.to_json }
    let(:input) do
      JSON.parse(
        File.read("spec/fixtures/generated/inputs/customers/natural_persons/create/valid_input.json"),
        symbolize_names: true
      )
    end
    let(:method) { :post }
    let(:path) { "entities/natural-persons" }

    context "with a valid payload" do
      let(:fixture) { "natural_persons/create/created" }

      it { expect(natural_person).to(be_a(Tangany::Customers::NaturalPerson)) }
    end

    context "with a conflicting payload" do
      let(:fixture) { "natural_persons/create/conflicting" }
      let(:status) { 409 }

      it "raises an error" do
        expect { natural_person }.to(
          raise_error(Tangany::RequestError)
          .with_message("Entity with given ID already exists.")
        )
      end
    end
  end

  describe "#delete" do
    subject(:response) { client.natural_persons.delete(entity_id) }

    let(:fixture) { "natural_persons/delete/#{entity_id}" }
    let(:method) { :delete }
    let(:path) { "entities/natural-persons/#{entity_id}" }

    context "with a valid entity ID" do
      let(:entity_id) { fetch_natural_person_id }

      it { expect(response.body).to(eq({})) }
      it { expect { response }.not_to(raise_error) }
    end

    context "with an invalid entity ID" do
      let(:entity_id) { "not_found" }
      let(:status) { 404 }

      it { expect { response }.to(raise_error(Tangany::RequestError).with_message("Resource not found")) }
    end
  end

  describe "#list" do
    subject(:natural_persons) { client.natural_persons.list(limit: limit, sort: sort) }

    let(:fixture) { "natural_persons/list/paginated" }
    let(:limit) { 1 }
    let(:path) { "entities/natural-persons?limit=#{limit}&sort=#{sort}" }
    let(:sort) { "asc" }

    it { expect(natural_persons).to(be_a(Tangany::Collection)) }
    it { expect(natural_persons.data.first.class).to(eq(Tangany::Customers::NaturalPerson)) }
    it { expect(natural_persons.total).to(eq(3)) }
    it { expect(natural_persons.next_page_token).to(eq("foo")) }
  end

  describe "#retrieve" do
    subject(:natural_person) { client.natural_persons.retrieve(entity_id) }

    let(:fixture) { "natural_persons/retrieve/#{entity_id}" }
    let(:path) { "entities/natural-persons/#{entity_id}" }

    context "with a valid entity ID" do
      let(:entity_id) { fetch_natural_person_id }

      it { expect(natural_person).to(be_a(Tangany::Customers::NaturalPerson)) }
    end

    context "with an invalid entity ID" do
      let(:entity_id) { "not_found" }
      let(:status) { 404 }

      it { expect { natural_person }.to(raise_error(Tangany::RequestError).with_message("Resource not found")) }
    end
  end

  describe "#update" do
    subject(:natural_person) { client.natural_persons.update(entity_id, **input) }

    let(:body) { input.to_json }
    let(:input) do
      JSON.parse(
        File.read("spec/fixtures/generated/inputs/customers/natural_persons/update/valid_input.json"),
        symbolize_names: true
      )
    end
    let(:method) { :put }
    let(:path) { "entities/natural-persons/#{entity_id}" }

    context "with a valid entity ID" do
      let(:entity_id) { fetch_natural_person_id }
      let(:fixture) { "natural_persons/update/updated" }

      it { expect(natural_person).to(be_a(Tangany::Customers::NaturalPerson)) }
    end

    context "with an invalid entity ID" do
      let(:entity_id) { "not_found" }
      let(:fixture) { "natural_persons/update/not_found" }
      let(:status) { 404 }

      it { expect { natural_person }.to(raise_error(Tangany::RequestError).with_message("Resource not found")) }
    end
  end

  private

  def fetch_natural_person_id
    Dir.glob("spec/fixtures/generated/responses/customers/natural_persons/retrieve/*.json").map do |file|
      id = File.basename(file, ".json")
      next unless id.match?(/[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i)

      id
    end.compact.min
  end
end
