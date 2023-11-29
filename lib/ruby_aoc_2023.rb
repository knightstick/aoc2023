# frozen_string_literal: true

require "ruby_aoc_2023/version"
require "ruby_aoc_2023/day_runner"
require "dotenv/load"

module RubyAoc2023
  class Error < StandardError; end

  class << self
    def greeting(name = "World")
      name = "World" if name.nil?
      "Hello, #{name}!"
    end

    def run_day(day: 1, iterations: 1)
      DayRunner.run(day:, iterations:)
    end

    def session
      ENV.fetch("AOC_SESSION")
    end
  end
end
