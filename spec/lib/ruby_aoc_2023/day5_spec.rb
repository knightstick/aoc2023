# frozen_string_literal: true

require "spec_helper"

RSpec.describe RubyAoc2023::Day5 do
  Rangey = RubyAoc2023::Day5::Rangey

  describe "transform" do
    # specify do
    #   [
    #     {
    #       subject: Rangey.new(range: (1..100), offset: 0),
    #       maps: [ Rangey.new(range: (1..2), offset: 1) ],
    #       expected: [
    #         Rangey.new(range: (1..2), offset: 1),
    #         Rangey.new(range: (3..100), offset: 0)
    #       ]
    #     },
    #     {
    #       subject: Rangey.new(range: (5..100), offset: 0),
    #       maps: [ Rangey.new(range: (1..2), offset: 1) ],
    #       expected: [
    #         Rangey.new(range: (5..100), offset: 0)
    #       ]
    #     },
    #     {
    #       subject: Rangey.new(range: (5..10), offset: 0),
    #       maps: [ Rangey.new(range: (1..100), offset: 1) ],
    #       expected: [
    #         Rangey.new(range: (5..10), offset: 1)
    #       ]
    #     }
    #   ].each do |test|
    #     subject = test[:subject]
    #     maps = test[:maps]
    #     expected = test[:expected]

    #     expect(subject.transform(maps)).to match_array(expected)
    #   end
    # end
  end
end
