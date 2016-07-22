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
  attr_reader :path
  attr_reader :facing
  attr_reader :current_position

  def initialize(maze)
    @maze = maze
    @current_position = maze.start
    @path = Path.new([current_position])
    @facing = Direction.new(:up)
  end

  def solve
    until over?
      step
    end
  end

  def print
    mark_from_path!
    puts maze.print
  end

  private

  def step
    if oriented?
      move_forward!
    else
      turn_right!
    end
    print
    sleep(0.5)
  end

  def turn_right!
    @facing.turn_right!
  end

  def oriented?
    to_my(:right).wall? && to_my(:front).empty?
  end

  def to_my(dir)
    to_the(facing.turn(dir))
  end

  def to_the(dir)
    pos = move(dir)
    if maze.out_of_bounds?(pos)
      Square.new('*')
    else
      maze.square(move(dir))
    end
  end

  def move(dir)
    current_position.move(dir)
  end

  def move_forward!
    @current_position = move(facing)
    @path << current_position
  end

  def mark!(pos)
    maze.square(pos).mark
  end

  def mark_from_path!
    path.each { |pos| maze.square(pos).mark! }
  end

  def over?
    won? || impossible?
  end

  def won?
    maze.square(current_position).finish?
  end

  def impossible?
    false
  end

end

if __FILE__ == $PROGRAM_NAME
  maze = Maze.new
  maze.read_text('aA_maze.txt')
  solver = Solver.new(maze)
  solver.solve
  solver.print
end

