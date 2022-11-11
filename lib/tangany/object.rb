module Tangany
  class Object < Dry::Struct
    class << self
      attr_reader :to_date_attributes, :to_datetime_attributes

      def new(args)
        translate_dates(args)
        translate_datetimes(args)
        super
      end

      def to_date(*attributes)
        @to_date_attributes ||= []
        @to_date_attributes += attributes
      end

      def to_datetime(*attributes)
        @to_datetime_attributes ||= []
        @to_datetime_attributes += attributes
      end

      private

      def translate_dates(args)
        (to_date_attributes || []).each do |attribute|
          next if args[:attribute].is_a?(Date)
          args[attribute] = Date.parse(args[attribute]) if args[attribute].present?
        end
      end

      def translate_datetimes(args)
        (to_datetime_attributes || []).each do |attribute|
          next if args[:attribute].is_a?(DateTime)
          args[attribute] = DateTime.parse(args[attribute]) if args[attribute].present?
        end
      end
    end

    def to_json
      to_h.to_json
    end
  end
end
