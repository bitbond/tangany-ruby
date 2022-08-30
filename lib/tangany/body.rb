# frozen_string_literal: true

require "dry-struct"

module Tangany
  class Body < Dry::Struct
    def to_json
      to_h.to_json
    end
  end
end
