#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


require_relative 'maze'
require_relative 'path'

class Solver
  attr_reader :maze
  attr_reader :exploration_history
  attr_reader :finish
  attr_reader :path
  attr_reader :step_time

  def initialize(maze)
    @maze = maze
    @exploration_history = [Explorer.new(maze.start, nil)]
    @end_not_found = true
    @finish = nil
    @path = Path.new
  end

  def solve!
    maze.validate
    explore!(maze.start)
    generate_path
  end

  def conclude(step_time = 0)
    @step_time = step_time

    if unsolved?
      puts unsolvable
    else
      show_solution
    end
  end

  private

  def explore!(pos)
    if maze.square(pos).finish?
      set_end(pos)
    end

    directions.each do |dir|
      new_pos = pos.move(dir)
      if explorable?(new_pos)
        update_history(Explorer.new(new_pos, pos))
        explore!(new_pos)
      end
    end
  end

  def show_solution
    path.each { |pos| step!(pos) }
    print_step if step_time == 0
  end

  def step!(pos)
    mark!(pos)
    if step_time > 0
      print_step
      sleep(step_time)
    end
  end

  def print_step
    puts
    puts maze.print
    puts
  end

  def directions
    [:up, :right, :down, :left]
  end

  def set_end(pos)
    @finish = false
    @finish = pos
  end

  def explorable?(pos)
    maze.square(pos).empty? &&
      !explored_squares.include?(pos) &&
      @end_not_found
  end

  def explored_squares
    exploration_history.map(&:pos)
  end

  def update_history(explorer)
    @exploration_history << explorer
  end

  def generate_path
    pos = finish

    while pos
      @path << pos
      pos = parrent(pos)
    end
    @path.remove_redundancies!.reverse!
  end

  def parrent(pos)
    index = exploration_history.index { |explorer| explorer.pos == pos }
    return nil unless index
    exploration_history[index].parrent
  end

  def mark!(pos)
    maze.square(pos).mark!
  end

  def unsolved?
    finish.nil?
  end

  def unsolvable
    "\nThis maze cannot be solved\n\n#{maze.print}\n\n"
  end

  Explorer = Struct.new(:pos, :parrent)
end

