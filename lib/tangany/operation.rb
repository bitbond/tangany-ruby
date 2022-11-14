module Tangany
  class Operation < Dry::Struct
    JSON_POINTER_REGEX = %r{(/[^/]+)+}

    attribute :op, Types::String.enum("add", "remove", "replace")
    attribute :path, Types::String.constrained(format: JSON_POINTER_REGEX)
    attribute? :from, Types::String.constrained(format: JSON_POINTER_REGEX)
    attribute? :value, Types::Bool | Types::Decimal | Types::Float | Types::Hash | Types::Integer | Types::String
  end
end
