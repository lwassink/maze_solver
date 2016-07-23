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
    @sleep_time = 0#.5
  end

  def solve
    print
    sleep(@sleep_time)
    orient!
    print
    sleep(@sleep_time)
    until over?
      step!
      print
      sleep(@sleep_time)
    end
  end

  def print
    mark_from_path!

    puts
    puts "Facing: #{facing}\tPosition: #{current_position}"
    puts "In front: #{to_my(:front)},\t On the right: #{to_my(:right)}"
    puts maze.print
    puts
  end

  private

  def step!
    if front_empty? && wall_on_right?
      move_forward!
    elsif right_empty?
      turn_right!
      move_forward!
    else
      turn_left!
    end
  end

  def orient!
    until front_empty? && wall_on_right?
      turn_right!
      print
      sleep(2 * @sleep_time)
    end
  end

  def turn_right!
    facing.turn_right!
  end

  def turn_left!
    facing.turn_left!
  end

  def front_empty?
    to_my(:front).empty?
  end

  def wall_on_right?
    to_my(:right).wall?
  end

  def right_empty?
    to_my(:right).empty?
  end

  def to_my(rel_dir)
    # puts "To my #{rel_dir} is #{facing.turn(rel_dir)}"
    to_the(facing.turn(rel_dir))
  end

  def to_the(dir)
    pos = move(dir)
    if maze.out_of_bounds?(pos)
      Square.new('*')
    else
      maze.square(pos)
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

