#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


require_relative 'maze'
require_relative 'solver'
require 'optparse'

time_message = "Step time in seconds, defults to 0. Change this to visually step through the maze"

step_time = 0

parser = OptionParser.new do |opts|
  opts.banner = "Usage: solve_maze.rb <file_name> [-t <step_time>, -h]"

  opts.on('-t', '--time time', time_message) do |time|
    step_time = time.to_f
  end

  opts.on('-h', '--help', "Display this help message") do
    puts opts
    exit
  end
end

parser.parse!

file_name = ARGV.pop
unless file_name
  raise "You must specify a file name. Use the -h flag for help."
end

maze = Maze.new
maze.read_text(file_name)
solver = Solver.new(maze)
solver.solve!
solver.conclude(step_time)

