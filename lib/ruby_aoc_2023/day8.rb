module RubyAoc2023
  module Day8
    class << self
      def part1(input)
        left_right, nodes = input.split("\n\n")
        map = parse_map(nodes)

        location = "AAA"
        i = 0

        loop do
          left_right.chars.each do |dir|
            return i if location == "ZZZ"

            location = map[location][(dir == "L") ? 0 : 1]
            i += 1
          end
        end
      end

      def part2(input)
        left_right, nodes = input.split("\n\n")
        map = parse_map(nodes)

        locations = map.keys.select { |k| k.end_with?("A") }
        locations.map do |loc|
          first_terminal(map, loc, left_right)
        end.reduce(:lcm)
      end

      def first_terminal(map, loc, left_right)
        current = loc
        i = 0

        loop do
          left_right.chars.each do |dir|
            return i if current.end_with?("Z")

            current = map[current][(dir == "L") ? 0 : 1]
            i += 1
          end
        end
      end

      def parse_map(nodes)
        nodes.split("\n").map do |line|
          name, instructions = line.split(" = ")
          [name, /\((\w*), (\w*)\)/.match(instructions).captures]
        end.to_h
      end
    end
  end
end
