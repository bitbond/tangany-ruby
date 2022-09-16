require "faker"

module Tangany
  class Factory
    class << self
      attr_reader :attributes

      def attribute(name, value)
        @attributes ||= {}
        @attributes[name] = value

        attr_accessor(name.to_s)
      end
    end

    def initialize(params = {})
      params = params.transform_keys(&:to_sym)
      self.class.attributes.each { |key, value| send("#{key}=", params[key.to_sym] || value.call(self)) }
    end

    def to_h
      self.class.attributes.map do |key, _|
        value = send(key)
        value = value.to_h if value.is_a?(Factory)
        [key, value]
      end.to_h
    end

    def to_json
      to_h.to_json
    end
  end
end
