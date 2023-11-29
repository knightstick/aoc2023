# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: %i[spec]

desc "Open an irb session with the gem pre-loaded"
task :console do
  exec "irb -r ./lib/ruby_aoc_2023.rb"
end
