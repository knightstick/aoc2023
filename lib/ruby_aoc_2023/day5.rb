module RubyAoc2023
  module Day5
    class Rangey
      def initialize(range:, offset:)
        @range = range
        @offset = offset
      end

      attr_reader :range, :offset

      def to_s
        "[(#{self.begin}, #{self.end}), #{offset}]"
      end

      def transform(layer)
        map, rest = layer

        the_start = self.begin + offset
        the_end = self.end + offset

        # if self.begin == 50
        #   puts "50"
        # end

        if map.nil?
          return [self]
        end

        # Off to the left
        if the_end < map.begin
          return transform(rest)
        end

        # Off to the right
        if the_start > map.end
          return transform(rest)
        end

        # Entirely contained
        if the_start >= map.begin && the_end <= map.end
          return [Rangey.new(range: range, offset: offset + map.offset)]
        end

        # Second half overlaps
        if the_start < map.begin && the_end <= map.end
          return Rangey.new(range: (self.begin..(map.begin - 1)), offset: offset).transform(rest) +
              [Rangey.new(range: (map.begin..self.end), offset: offset + map.offset)]
        end

        # First half overlaps
        if the_start <= map.end && the_end > map.end
          return [Rangey.new(range: (self.begin..map.end), offset: offset + map.offset)] +
              Rangey.new(range: ((map.end + 1)..self.end), offset:).transform(rest)
        end

        raise NotImplementedError
      end

      # def __transform(layer)
      #   other = layer.find do |other|
      #     overlap?(other)
      #   end

      #   if other
      #     single_transform(other)
      #   else
      #     self
      #   end
      # end

      # def _transform(layer)
      #   layer.reduce([self]) do |acc, other|
      #     acc.flat_map do |rangey|
      #       rangey.single_transform(other)
      #     end
      #   end
      # end

      # def single_transform(other)
      #   if overlap?(other)
      #     split(other)
      #   else
      #     self
      #   end
      # end

      # def overlap?(rangey)
      #   (self.begin >= rangey.begin && self.begin <= rangey.end) ||
      #     (self.end >= rangey.begin && self.end <= rangey.end)
      # end

      # def _overlap?(rangey)
      #   begin_offset = self.begin + offset
      #   end_offset = self.end + offset
      #   (begin_offset >= rangey.begin && begin_offset <= rangey.end) ||
      #     (end_offset >= rangey.begin && end_offset <= rangey.end)
      # end

      def begin
        range.begin
      end

      def end
        range.end
      end

      def ==(other)
        self.begin == other.begin && self.end == other.end && offset == other.offset
      end

      def min
        self.begin + offset
      end

      def wrap(maybe)
        return maybe if maybe.is_a?(Array)

        [maybe]
      end
    end

    class << self
      def _part1(input)
        seeds, *rest = input.split("\n\n")
        seeds = seeds.split(": ")[1].split(" ").map(&method(:Integer))

        maps = rest.map do |lines|
          lines.split("\n")[1..].map do |row|
            dest, source, len = row.split(" ").map(&method(:Integer))
            {dest: dest, source: source, len: len}
          end
        end

        locations = seeds.map do |seed|
          location(seed, maps)
        end

        locations.min
      end

      def solve(seeds, maps)
        seeds.map do |seed|
          maps.reduce([seed]) do |acc, layer|
            acc_str = acc.map(&:to_s).join(", ")
            acc.flat_map do |rangey|
              rangey.transform(layer)
            end
          end.tap do |ranges|
            puts ranges.inspect
          end.map(&:min).min
        end.tap do |mins|
        end.min
      end

      def part1(input)
        seedstr, *rest = input.split("\n\n")
        seeds = seedstr.split(": ")[1].split(" ").map(&method(:Integer)).map do |start|
          range = (start..start)
          Rangey.new(range:, offset: 0)
        end

        maps = rest.map do |lines|
          lines.split("\n")[1..].map do |row|
            dest, source, len = row.split(" ").map(&method(:Integer))
            range = (source..(source + len - 1))
            Rangey.new(range:, offset: dest - source)
          end
        end

        solve(seeds, maps)
      end

      def part2(input)
        # return -1

        seedstr, *rest = input.split("\n\n")

        seeds = seedstr.split(": ")[1].split(" ").map(&method(:Integer)).each_slice(2).map do |start, len|
          range = (start..(start + len - 1))
          Rangey.new(range:, offset: 0)
        end

        maps = rest.map do |lines|
          lines.split("\n")[1..].map do |row|
            dest, source, len = row.split(" ").map(&method(:Integer))
            range = (source..(source + len - 1))
            Rangey.new(range:, offset: dest - source)
          end
        end

        solve(seeds, maps)
      end

      def location(seed, maps)
        result = seed

        maps.each do |map_cat|
          result = step(result, map_cat)
        end

        result
      end

      def step(num, map_cat)
        map = map_cat.find do |a_map|
          source = a_map[:source]
          len = a_map[:len]

          (source...(source + len)).include?(num)
        end

        if map.nil?
          num
        else
          offset = num - map[:source]
          map[:dest] + offset
        end
      end
    end
  end
end

input = <<~INPUT
  seeds: 79 14 55 13

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
INPUT

input2 = <<~INPUT
  seeds: 0 100

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
INPUT

input3 = <<~INPUT
  seeds: 0 100

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
INPUT

# puts RubyAoc2023::Day5.part1(input2)
# puts RubyAoc2023::Day5.part2(input2)
# puts RubyAoc2023::Day5.part1(input)
# puts RubyAoc2023::Day5.part2(input)
