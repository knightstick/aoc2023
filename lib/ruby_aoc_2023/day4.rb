module RubyAoc2023
  module Day4
    class << self
      def part1(input)
        input.split("\n")
          .map(&method(:parse_line))
          .map(&method(:score_line))
          .sum
      end

      def part2(input)
        cards = input.split("\n")
          .map(&method(:parse_line))

        pile = []

        (0...cards.length).each do |card_n|
          pile[card_n] = 1
        end

        (0...cards.length).each do |card_n|
          card = cards[card_n]
          copies = pile[card_n]

          winners = winners(card)

          (card_n + 1..card_n + winners).each do |winner_n|
            pile[winner_n] += copies
          end
        end

        pile.sum
      end

      def parse_line(line)
        _, line = line.split(": ")
        winning, held = line.split(" | ")
        [parse_numbers(winning), parse_numbers(held)]
      end

      def winners(card)
        winning, held = card
        hits = winning & held
        hits.length
      end

      def score_line(line)
        winning, held = line
        hits = winning & held
        if hits.any?
          2**(hits.length - 1)
        else
          0
        end
      end

      def parse_numbers(str)
        Set.new(str.strip.split(" ").map(&method(:Integer)))
      end
    end
  end
end
