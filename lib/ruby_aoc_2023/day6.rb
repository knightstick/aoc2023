module RubyAoc2023
  module Day6
    class << self
      def part1(input)
        time, distances = input.split("\n")
        times = time.split(":")[1].split.map(&method(:Integer))
        distances = distances.split(":")[1].split.map(&method(:Integer))

        times.zip(distances).map do |time, distance|
          count_the_ways(time:, distance:)
        end.reduce(:*)
      end

      def part2(input)
        time, distances = input.split("\n")
        time = Integer(time.split(":")[1].split.join)
        distance = Integer(distances.split(":")[1].split.join)
        count_the_ways(time: time, distance: distance)
      end

      def count_the_ways(time:, distance:)
        (0..time).count do |t|
          remaining_time = time - t
          actual = t * remaining_time
          actual > distance
        end
      end
    end
  end
end
