module Tangany
  class Collection
    attr_reader :data, :next_page_token, :next_path, :previous_path, :total

    def initialize(data:, total:, next_page_token: nil, next_path: nil, previous_path: nil)
      @data = data
      @next_page_token = next_page_token
      @next_path = next_path
      @previous_path = previous_path
      @total = total
    end
  end
end
