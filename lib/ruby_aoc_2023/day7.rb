module RubyAoc2023
  module Day7
    class JokerHand
      include Comparable

      def initialize(card_str:, bet_s:)
        @card_labels = card_str.chars
        @cards = card_labels.each_with_object({}) do |card, memo|
          next if card == "J"

          memo[card] ||= 0
          memo[card] += 1
        end

        @bet = Integer(bet_s)
        @joker_count = card_labels.count("J")
      end

      attr_reader :cards, :bet

      def <=>(other)
        if hand_class == other.hand_class
          card_labels.map(&method(:rank_num)) <=> other.card_labels.map(&method(:rank_num))
        else
          other.hand_class <=> hand_class
        end
      end

      protected

      attr_reader :card_labels, :joker_count

      def hand_class
        return 0 if five_of_a_kind?
        return 1 if four_of_a_kind?
        return 2 if full_house?
        return 3 if three_of_a_kind?
        return 4 if two_pair?
        return 5 if one_pair?

        6
      end

      def rank_num(rank)
        %w[J 2 3 4 5 6 7 8 9 T Q K A].index(rank)
      end

      private

      def five_of_a_kind?
        cards.values.max == 5 ||
          ((cards.values.max || 0) + joker_count == 5)
      end

      def four_of_a_kind?
        cards.values.max == 4 ||
          (cards.values.max + joker_count == 4)
      end

      def full_house?
        cards.values.sort == [2, 3] ||
          (cards.values.sort == [2, 2] && joker_count == 1)
      end

      def three_of_a_kind?
        !full_house? && (cards.values.max == 3 || cards.values.max + joker_count == 3)
      end

      def two_pair?
        cards.values.sort == [1, 2, 2]
      end

      def one_pair?
        !two_pair? && (cards.values.max == 2 || cards.values.max + joker_count == 2)
      end
    end

    class Hand
      include Comparable

      def initialize(card_str:, bet_s:)
        @card_labels = card_str.chars
        @cards = card_labels.each_with_object({}) do |card, memo|
          memo[card] ||= 0
          memo[card] += 1
        end

        @bet = Integer(bet_s)
      end

      attr_reader :cards, :bet

      def <=>(other)
        if hand_class == other.hand_class
          card_labels.map(&method(:rank_num)) <=> other.card_labels.map(&method(:rank_num))
        else
          other.hand_class <=> hand_class
        end
      end

      protected

      attr_reader :card_labels

      def hand_class
        return 0 if five_of_a_kind?
        return 1 if four_of_a_kind?
        return 2 if full_house?
        return 3 if three_of_a_kind?
        return 4 if two_pair?
        return 5 if one_pair?

        6
      end

      def rank_num(rank)
        %w[2 3 4 5 6 7 8 9 T J Q K A].index(rank) + 2
      end

      private

      def five_of_a_kind?
        cards.values.max == 5
      end

      def four_of_a_kind?
        cards.values.max == 4
      end

      def full_house?
        cards.values.sort == [2, 3]
      end

      def three_of_a_kind?
        !full_house? && cards.values.max == 3
      end

      def two_pair?
        cards.values.sort == [1, 2, 2]
      end

      def one_pair?
        !two_pair? && cards.values.max == 2
      end
    end

    class << self
      def part1(input)
        input.strip.split("\n")
          .map(&method(:parse_hand))
          .sort
          .map.with_index { |hand, idx| hand.bet * (idx + 1) }
          .sum
      end

      def part2(input)
        input.strip.split("\n")
          .map(&method(:parse_joker_hand))
          .sort
          .map.with_index { |hand, idx| hand.bet * (idx + 1) }
          .sum
      end

      def parse_hand(line)
        cards, bet = line.split(" ")

        Hand.new(card_str: cards, bet_s: bet)
      end

      def parse_joker_hand(line)
        cards, bet = line.split(" ")

        JokerHand.new(card_str: cards, bet_s: bet)
      end
    end
  end
end
