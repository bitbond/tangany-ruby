module Tangany
  class Object < Dry::Struct
    class << self
      attr_reader :censored_attributes, :to_date_attributes, :to_datetime_attributes

      def new(args)
        set_censored_attributes(args)
        translate_dates(args)
        translate_datetimes(args)
        super
      end

      def censored(*attributes)
        @censored_attributes ||= []
        @censored_attributes += attributes
        attributes.each do |attribute|
          attribute "#{attribute}Censored".to_sym, Types::String.optional
        end
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

      def set_censored_attributes(args)
        (censored_attributes || []).each do |attribute|
          args["#{attribute}Censored".to_sym] = args.delete(attribute.to_sym)
        end
      end

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
