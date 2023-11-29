# frozen_string_literal: true

require "ruby_aoc_2023"
require "dry/cli"

module RubyAoc2023
  class CLI
    module Commands
      extend Dry::CLI::Registry

      class Version < Dry::CLI::Command
        desc "Print version"

        def call(*)
          puts RubyAoc2023::VERSION
        end
      end

      class Greeting < Dry::CLI::Command
        desc "Print greeting"

        argument :name, desc: "The name to greet"

        def call(name: nil, **)
          puts RubyAoc2023.greeting(name)
        end
      end

      class RunDay < Dry::CLI::Command
        desc "Run a given day"

        argument :day, type: :integer, desc: "The day to run", default: nil
        option :iterations, type: :integer, desc: "The number of times to run each iteration", default: 1
        option :verbose, type: :boolean, default: false, desc: "Verbose mode"

        def call(verbose:, day: nil, iterations: 1, **)
          if day.nil?
            part1, part2 = RubyAoc2023.run_day(day: nil, iterations: Integer(iterations))
          else
            part1, part2 = RubyAoc2023.run_day(day: Integer(day), iterations: Integer(iterations))
          end

          puts part1.answer
          puts "(took #{part1.runtime} seconds)" if verbose
          puts part2.answer
          puts "(took #{part1.runtime} seconds)" if verbose
        end
      end

      class Session < Dry::CLI::Command
        desc "Show the session being used"

        def call(*)
          puts RubyAoc2023.session
        end
      end

      register "version", Version, aliases: ["v", "-v", "--version"]
      register "greeting", Greeting, aliases: ["g"]
      register "day", RunDay, aliases: ["d"]
      register "session", Session
    end
  end
end
