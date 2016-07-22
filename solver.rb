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
  attr_reader :path
  attr_reader :facing
  attr_reader :current_position

  @@directions = [:up, :right, :down, :left]

  def initialize(maze)
    @maze = maze
    @current_position = maze.start
    @path = Path.new([current_position])
    @facing = :up
  end

  def solve
    until over?
      step
    end
  end

  def print
    mark_from_path
    puts maze.print
  end

  private

  def step
    if oriented?
      move_forward
    else
      turn_right
    end
    # print
    # sleep(0.5)
  end

  def turn_right
    @facing = rotate_right(facing)
  end

  def rotate_right(dir)
    current_index = @@directions.index(dir)
    new_index = (current_index + 1) % 4
    @@directions[new_index]
  end

  def oriented?
    to_my(:right).wall? && to_my(:up).empty?
  end

  def to_my(dir)
    rotation = @@directions.index(facing)
    rotation.times { dir = rotate_right(dir) }
    to_the(dir)
  end

  def to_the(dir)
    pos = move(dir)
    if maze.out_of_bounds?(pos)
      Square.new('*')
    else
      maze[*move(dir)]
    end
  end

  def move(dir)
    x, y = current_position
    case dir
    when :up
      [x, y-1]
    when :right
      [x+1, y]
    when :down
      [x, y+1]
    when :left
      [x-1, y]
    end
  end

  def move_forward
    @current_position = move(facing)
    @path << @current_position
  end

  def mark(pos)
    maze[*pos].mark
  end

  def mark_from_path
    path.each { |pos| mark(pos) }
  end

  def over?
    won? || impossible?
  end

  def won?
    maze[*current_position].finish?
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

