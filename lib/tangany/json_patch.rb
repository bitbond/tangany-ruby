module Tangany
  class JsonPatch
    attr_reader :operations

    def initialize(old_hash, new_hash, prefix = "")
      raise ArgumentError, "Old hash must be a Hash" unless old_hash.is_a?(Hash)
      raise ArgumentError, "New hash must be a Hash" unless new_hash.is_a?(Hash)
      raise ArgumentError, "Prefix must be a String" unless prefix.is_a?(String)

      @old_hash = old_hash
      @new_hash = new_hash
      @prefix = prefix

      @keys = old_hash.keys | new_hash.keys
      @operations = []
    end

    def generate
      keys.each do |key, value|
        old_value = old_hash[key]
        new_value = new_hash[key]
        generate_ops(key, old_value, new_value)
      end
      operations
    end

    def to_json
      operations.to_json
    end

    private

    attr_reader :keys, :new_hash, :old_hash, :prefix

    def add_op(key, value)
      operations << {op: "add", path: "#{prefix}/#{key}", value: value}
    end

    def generate_ops(key, old_value, new_value)
      if old_value.is_a?(Hash) && new_value.is_a?(Hash)
        @operations += JsonPatch.new(old_value, new_value, [prefix, key].join("/")).generate
      elsif old_value != new_value
        append_op(key, new_value)
      end
    end

    def append_op(key, value)
      if !old_hash.has_key?(key)
        add_op(key, value)
      elsif !new_hash.has_key?(key)
        remove_op(key)
      else
        replace_op(key, value)
      end
    end

    def remove_op(key)
      operations << {op: "remove", path: "#{prefix}/#{key}"}
    end

    def replace_op(key, value)
      operations << {op: "replace", path: "#{prefix}/#{key}", value: value}
    end
  end
end
