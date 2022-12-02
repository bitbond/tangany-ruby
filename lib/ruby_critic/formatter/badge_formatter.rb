module RubyCritic
  module Formatter
    class BadgeFormatter
      COLORS = {
        0..59 => "red",
        60..69 => "orange",
        70..79 => "yellow",
        70..84 => "yellowgreen",
        85..89 => "green",
        90..100 => "brightgreen"
      }.freeze

      def initialize(analysed_modules)
        @percentage = analysed_modules.score.to_i
      end

      def generate_report
        readme_update
      end

      private

      attr_reader :percentage

      def readme_update
        color = COLORS.find { |range, _| range.include?(percentage) }.last
        badge = "![Code quality](https://img.shields.io/badge/quality-#{percentage}%25-#{color})"
        File.write("README.md", File.read("README.md").gsub(/!\[Code quality\]\(.*\)/, badge))
      end
    end
  end
end
