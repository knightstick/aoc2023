module RubyAoc2023
  module Day2
    class << self
      BAG = {
        "red" => 12,
        "green" => 13,
        "blue" => 14
      }

      def part1(input)
        games = input.strip.split("\n").map(&method(:game))
        games.map.with_index do |game, i|
          if valid_game?(game)
            i + 1
          else
            0
          end
        end.sum
      end

      def part2(input)
        games = input.strip.split("\n").map(&method(:game))
        games.map(&method(:maxes))
          .map(&method(:power))
          .sum
      end

      def game(line)
        _, game_str = line.split(": ")
        game_str.split("; ").map(&method(:parse_sub_game))
      end

      def valid_game?(game)
        maxes(game).all? do |color, count|
          BAG[color] >= count
        end
      end

      def maxes(game)
        game.each_with_object(Hash.new(0)) do |sub_game, acc|
          sub_game.each_with_object(acc) do |sub_item, acc|
            color, count = sub_item.first
            if acc[color] < count
              acc[color] = count
            end
          end
        end
      end

      def power(maxes)
        maxes.values.reduce(:*)
      end

      def parse_sub_game(sub_game_str)
        sub_game_str.split(", ").map(&method(:parse_sub_game_item))
      end

      def parse_sub_game_item(sub_game_item_str)
        num_s, color = sub_game_item_str.split(" ")
        {color => Integer(num_s)}
      end
    end
  end
end
