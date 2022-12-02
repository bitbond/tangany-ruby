module SimpleCov
  module Formatter
    class BadgeFormatter
      COLORS = {
        0..69 => "red",
        70..79 => "orange",
        80..89 => "yellow",
        90..94 => "yellowgreen",
        95..99 => "green",
        100..100 => "brightgreen"
      }.freeze

      def format(result)
        percentage = result.source_files.covered_percent.to_i
        readme_update(percentage)
      end

      private

      def readme_update(percentage)
        color = COLORS.find { |range, _| range.include?(percentage) }.last
        badge = "![coverage](https://img.shields.io/badge/coverage-#{percentage}%25-#{color})"
        File.write("README.md", File.read("README.md").gsub(/!\[coverage\]\(.*\)/, badge))
      end
    end
  end
end
