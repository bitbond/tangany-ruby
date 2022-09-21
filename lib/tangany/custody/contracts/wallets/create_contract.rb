module Tangany
  module Custody
    module Wallets
      class CreateContract < ApplicationContract
        TagSchema = Dry::Schema.Params do
          10.times do |i|
            optional("tag#{i}".to_sym).maybe(:string, max_size?: 256)
          end
        end

        schema do
          config.validate_keys = true

          optional(:wallet).filled(:string, max_size?: 127, min_size?: 1)
          optional(:useHsm).filled(:bool)
          optional(:tags).array(TagSchema)
        end
      end
    end
  end
end
