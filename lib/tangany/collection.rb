# frozen_string_literal: true

module Tangany
  class Collection
    attr_reader :data, :total, :next_path, :previous_path

    class << self
      def from_response(response, type:)
        body = response.body
        new(
          data: body[:results].map { |attributes| type.new(attributes) },
          total: body[:total],
          next_path: body.dig(:_links, :next),
          previous_path: body.dig(:_links, :previous)
        )
      end
    end

    def initialize(data:, total:, next_path:, previous_path:)
      @data = data
      @total = total
      @next_path = next_path
      @previous_path = previous_path
    end
  end
end
