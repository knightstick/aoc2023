# frozen_string_literal: true

require "net/http"
require "uri"

require "ruby_aoc_2023"

# require all "day" files
Dir.glob(File.join(File.dirname(__FILE__), "day[0123456789]*.rb")).each do |file|
  require file
end

module RubyAoc2023
  module Day0
    class << self
      def part2(_input)
        -1
      end
    end
  end

  class DayRunner
    Result = Struct.new(:answer, :runtime)

    class << self
      def run(day:, iterations: 1)
        return run_highest_day(iterations:) if day.nil?

        day_class = RubyAoc2023.const_get("Day#{day}")
        new(klass: day_class, iterations:).run
      rescue NameError
        raise NotImplementedError, "Day #{day.inspect} not implemented"
      end

      def run_highest_day(iterations: 1)
        day_files = Dir.glob(File.join(File.dirname(__FILE__), "day[0123456789]*.rb"))
        highest_file_absolute = day_files.sort do |a, b|
          Integer(a.match(/day(\d+)\.rb/)[1]) <=> Integer(b.match(/day(\d+)\.rb/)[1])
        end.last

        return run(day: 0) if highest_file_absolute.nil?

        highest_filename = highest_file_absolute.split("/").last
        # Get the number from the filename, e.g. day3.rb => 3
        highest_number = highest_filename.match(/day(\d+)\.rb/)[1].to_i
        run(day: highest_number, iterations:)
      end

      def load_input(day_number)
        File.read(day_file_path(day_number))
      rescue Errno::ENOENT
        download_input(day_number)
      end

      def download_input(day_number)
        input = fetch_input(day_number)
        File.write(day_file_path(day_number), input)
        File.read(day_file_path(day_number))
      end

      def fetch_input(day_number)
        http, request = build_request(day_number)

        raise "Not supposed to send" unless ENV.fetch("SEND_REQUEST", "false") == "true"

        response = http.request(request)
        response.body
      end

      def build_request(day_number)
        uri = URI.parse("https://adventofcode.com/2023/day/#{day_number}/input")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        request["Cookie"] = "session=#{RubyAoc2023.session}"
        [http, request]
      end

      def day_file_path(number)
        "inputs/day#{number}.txt"
      end
    end

    def initialize(klass:, iterations: 1)
      @klass = klass
      @input = self.class.load_input(day_number)
      @iterations = iterations
    end

    def run
      require "benchmark"

      p1 = nil
      p2 = nil

      t1 = Benchmark.measure do
        iterations.times do
          p1 = part1
        end
      end
      t2 = Benchmark.measure do
        iterations.times do
          p2 = part2
        end
      end

      [
        Result.new(p1, t1.real),
        Result.new(p2, t2.real)
      ]
    end

    private

    attr_reader :klass,
      :input,
      :iterations

    def part1
      return -1 unless klass.singleton_class.method_defined?(:part1)

      klass.part1(input)
    end

    def part2
      return -1 unless klass.singleton_class.method_defined?(:part2)

      klass.part2(input)
    end

    def day_number
      Integer(klass.name.split("::").last.downcase[3..])
    end
  end
end
