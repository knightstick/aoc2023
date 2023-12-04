module RubyAoc2023
  module Day3
    class << self
      def part1(input)
        grid = input.split("\n").map(&:chars)
        part_numbers = []

        grid.each.with_index do |line, line_index|
          buffer = []
          part_number = false

          line.each.with_index do |char, char_index|
            if /\d/.match?(char)
              buffer << char

              part_number = true if adjacent_to_symbol?(line_index, char_index, grid)
            else
              part_numbers << buffer.join.to_i if part_number
              buffer = []
              part_number = false
            end
          end

          part_numbers << buffer.join.to_i if part_number
        end

        part_numbers.sum
      end

      def part2(input)
        grid = input.split("\n").map(&:chars)
        gears = {}

        grid.each.with_index do |line, line_index|
          buffer = []
          potential_gear = nil

          line.each.with_index do |char, char_index|
            if /\d/.match?(char)
              buffer << char

              potential_gear ||= potential_gear?(line_index, char_index, grid)
            else
              if potential_gear
                gears[potential_gear.inspect] ||= []
                gears[potential_gear.inspect] << buffer.join.to_i
              end
              buffer = []
              potential_gear = nil
            end
          end

          if potential_gear
            gears[potential_gear.inspect] ||= []
            gears[potential_gear.inspect] << buffer.join.to_i
          end
        end

        gears.values.select do |part_numbers|
          part_numbers.length == 2
        end.map do |(x, y)|
          x * y
        end.sum
      end

      def char_at(line_index, char_index, grid)
        return if line_index < 0 || char_index < 0
        return if line_index >= grid.length || char_index >= grid.first.length

        grid[line_index][char_index]
      rescue
        nil
      end

      def adjacent_to_symbol?(line_index, char_index, grid)
        regex = /[^0-9.]/
        return true if char_at(line_index - 1, char_index, grid)&.match?(regex)
        return true if char_at(line_index + 1, char_index, grid)&.match?(regex)
        return true if char_at(line_index, char_index - 1, grid)&.match?(regex)
        return true if char_at(line_index, char_index + 1, grid)&.match?(regex)
        return true if char_at(line_index - 1, char_index - 1, grid)&.match?(regex)
        return true if char_at(line_index + 1, char_index - 1, grid)&.match?(regex)
        return true if char_at(line_index - 1, char_index + 1, grid)&.match?(regex)
        return true if char_at(line_index + 1, char_index + 1, grid)&.match?(regex)

        false
      end

      def potential_gear?(line_index, char_index, grid)
        (-1..1).each do |line_offset|
          (-1..1).each do |char_offset|
            next if line_offset == 0 && char_offset == 0

            char = char_at(line_index + line_offset, char_index + char_offset, grid)

            if char == "*"
              return [(line_index + line_offset), (char_index + char_offset)]
            end
          end
        end

        nil
      end
    end
  end
end
