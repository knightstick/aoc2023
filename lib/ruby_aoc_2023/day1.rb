module RubyAoc2023
  module Day1
    class << self
      def part1(input)
        input.split.map(&method(:calibration_value)).sum
      end

      def part2(input)
        input.split.map(&method(:calibration_value2)).sum
      end

      def calibration_value(line)
        digits = line.chars.map do |char|
          Integer(char)
        rescue
          nil
        end.compact

        first = digits.first
        last = digits.last
        Integer("#{first}#{last}")
      end

      def calibration_value2(line)
        digits = (0..line.length - 1).map do |i|
          char = line[i]
          digit = begin
            Integer(char)
          rescue
            nil
          end

          if digit.nil?
            maybe_string_digit(i, line)
          else
            digit
          end
        end.compact

        first = digits.first
        last = digits.last
        Integer("#{first}#{last}")
      end

      def maybe_string_digit(i, line)
        string = line[i..]
        words = %w[zero one two three four five six seven eight nine]

        words.each_with_index do |word, index|
          return index if string.start_with?(word)
        end

        nil
      end
    end
  end
end
