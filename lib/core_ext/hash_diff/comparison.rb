module CoreExt
  module HashDiff
    module Comparison
      def to_operations_json
        to_operations(diff).map(&:to_h).to_json
      end

      private

      def build_params(key:, prefix:, new_value:, old_value:)
        op = "add" if old_value == ::HashDiff::NO_VALUE
        op ||= "remove" if new_value == ::HashDiff::NO_VALUE
        op ||= "replace"

        ret = {
          op: op,
          path: "#{prefix}/#{key}"
        }
        ret[:value] = new_value if new_value != ::HashDiff::NO_VALUE
        ret
      end

      def to_operations(hash, prefix: "")
        hash.each_with_object([]) do |(key, value), results|
          results << if value.is_a?(Hash)
            to_operations(value, prefix: "#{prefix}/#{key}")
          else
            params = build_params(key: key, prefix: prefix, new_value: value[0], old_value: value[1])
            Tangany::Operation.new(params)
          end
        end.flatten
      end
    end
  end
end

HashDiff::Comparison.include(CoreExt::HashDiff::Comparison)
