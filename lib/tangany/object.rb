# frozen_string_literal: true

module Tangany
  class Object < Dry::Struct
    class << self
      def merge(object_a, object_b)
        hash_a = object_a.to_h
        hash_b = object_b.to_h
        hash_merge = hash_a.deep_merge(hash_b)
        new(**hash_merge)
      end
    end

    def to_json
      to_h.to_json
    end
  end
end
