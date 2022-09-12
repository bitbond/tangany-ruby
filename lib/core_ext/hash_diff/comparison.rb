# frozen_string_literal: true

module CoreExt
  module HashDiff
    module Comparison
      def to_operations_json
        to_operations(diff).map(&:to_h).to_json
      end

      private

      def to_operations(hash, prefix: "")
        hash.each_with_object([]) do |(key, value), results|
          results << if value.is_a?(Hash)
            to_operations(value, prefix: "#{prefix}/#{key}")
          else
            Tangany::Operation.new(
              op: value[1] == ::HashDiff::NO_VALUE ? "add" : "replace",
              path: "#{prefix}/#{key}",
              value: value[0]
            )
          end
        end.flatten
      end
    end
  end
end

HashDiff::Comparison.include(CoreExt::HashDiff::Comparison)
