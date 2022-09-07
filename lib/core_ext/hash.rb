# frozen_string_literal: true

class Hash
  # From https://github.com/rails/rails/blob/v7.0.3.1/activesupport/lib/active_support/core_ext/hash/deep_merge.rb
  # Licensed under https://github.com/rails/rails/blob/v7.0.3.1/MIT-LICENSE

  def deep_merge(other_hash, &block)
    dup.deep_merge!(other_hash, &block)
  end

  def deep_merge!(other_hash, &block)
    merge!(other_hash) do |key, this_val, other_val|
      if this_val.is_a?(Hash) && other_val.is_a?(Hash)
        this_val.deep_merge(other_val, &block)
      elsif block_given?
        block.call(key, this_val, other_val)
      else
        other_val
      end
    end
  end
end
