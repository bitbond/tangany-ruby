module Tangany
  class Collection
    attr_reader :data, :total, :next_path, :previous_path

    def initialize(data:, total:, next_path:, previous_path:)
      @data = data
      @total = total
      @next_path = next_path
      @previous_path = previous_path
    end
  end
end
