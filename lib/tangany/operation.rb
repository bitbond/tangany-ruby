module Tangany
  class Operation < Dry::Struct
    JSON_POINTER_REGEXP = %r{(/[^/]+)+}

    attribute :op, Types::String.enum("add", "replace")
    attribute :path, Types::String.constrained(format: JSON_POINTER_REGEXP)
    attribute :from?, Types::String.constrained(format: JSON_POINTER_REGEXP)
    attribute :value?, Types::Bool | Types::Decimal | Types::Float | Types::Hash | Types::Integer | Types::String
  end
end
