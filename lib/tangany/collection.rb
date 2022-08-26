# frozen_string_literal: true

module Tangany
  class Collection
    attr_reader :data, :total, :next_cursor, :prev_cursor

    class << self
      def from_response(response, type:)
        body = response.body
        new(
          data: body["results"].map { |attributes| type.new(attributes.deep_symbolize_keys) },
          total: body["total"],
          next_cursor: body.dig("_links", "next"),
          prev_cursor: body.dig("_links", "prev")
        )
      end
    end

    def initialize(data:, total:, next_cursor:, prev_cursor:)
      @data = data
      @total = total
      @next_cursor = next_cursor
      @prev_cursor = prev_cursor
    end
  end
end
