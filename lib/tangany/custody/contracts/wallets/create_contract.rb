module Tangany
  module Custody
    module Wallets
      class CreateContract < Contract
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

        rule(:tags).each do
          key.failure("invalid tag name, must contain following characters: 0-9, a-z, A-Z, - and _ (100 chars max)") unless value.keys[0].match?(/\A[0-9a-zA-Z-_]{1,100}\z/)
          key.failure("is not valid, maximum length is 256 characters") unless value.values[0].size <= 256
        end
      end
    end
  end
end
