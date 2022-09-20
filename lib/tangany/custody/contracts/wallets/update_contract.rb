module Tangany
  module Custody
    module Wallets
      class UpdateContract < Contract
        TagSchema = Dry::Schema.Params do
          10.times do |i|
            optional("tag#{i}".to_sym).maybe(:string, max_size?: 256)
          end
        end

        schema do
          config.validate_keys = true

          optional(:tags).array(TagSchema)
        end
      end
    end
  end
end