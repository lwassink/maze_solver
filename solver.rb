#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


require_relative 'maze'
require_relative 'path'
require_relative 'direction'

class Solver
  attr_reader :maze
  attr_reader :exploration_history
  attr_reader :finish
  attr_reader :path

  def initialize(maze)
    @maze = maze
    @exploration_history = [Explorer.new(maze.start, nil)]
    @end_not_found = true
    @finish = nil
    @path = Path.new
  end

  def solve!
    explore(maze.start)
    generate_path
    conclude
    puts path
  end

  def print
    puts
    puts "Exploration history: #{exploration_history}"
    puts "Explored square: #{explored_squares}"
    puts maze.print
    puts
  end

  private

  def explore(pos)
    proccess(pos)

    if maze.square(pos).finish?
      set_end(pos)
    end

    directions.each do |dir|
      new_pos = pos.move(dir)
      if explorable?(new_pos)
        update_history(Explorer.new(new_pos, pos))
        explore(new_pos)
      end
    end
  end

  def proccess(pos)
    mark!(pos)
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
    @path.reverse!
  end

  def parrent(pos)
    index = exploration_history.index { |explorer| explorer.pos == pos }
    return nil unless index
    exploration_history[index].parrent
  end

  def conclude
    maze.reset_marks!
    mark_path!
    print
  end

  def mark_path!
    path.each { |pos| mark!(pos) }
  end

  def mark!(pos)
    maze.square(pos).mark!
  end

  Explorer = Struct.new(:pos, :parrent)
end

if __FILE__ == $PROGRAM_NAME
  maze = Maze.new
  maze.read_text('aA_maze.txt')
  solver = Solver.new(maze)
  solver.solve!
  solver.print
end

