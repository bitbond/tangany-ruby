module Tangany
  class Object < Dry::Struct
    def to_json
      to_h.to_json
    end
  end
end
