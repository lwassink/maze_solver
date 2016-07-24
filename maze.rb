#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


require_relative 'path'
require_relative 'square'
require_relative 'position'

class Maze
  attr_reader :grid

  def initialize(grid = nil)
    @grid = grid || [[Square.new(' ')]]
  end

  def [](x, y)
    square(Position.new(x, y))
  end

  def square(pos)
    return Square.new('*') if out_of_bounds?(pos)
    grid[pos.y][pos.x]
  end

  def start
    begin
      find_pos(:start?)
    rescue
      throw "Failed call to Maze#start: this maze does not have a start"
    end
  end

  def read_text(file)
    @grid = text_to_grid(read_file(file))
  end

  def x_bound
    grid[0].length
  end

  def y_bound
    grid.length
  end

  def to_s
    grid.map { |row| print_row(row) }.join("\n")
  end

  def print
    grid.map { |row| print_with_marks(row) }.join("\n")
  end

  def ==(other)
    grid == other.grid
  end

  def out_of_bounds?(pos)
    x, y = pos.x, pos.y
    x < 0 || x_bound <= x || y < 0 || y_bound <= y
  end

  def reset_marks!
    each { |square| square.unmark! }
  end

  def validate
    validate_characters
    validate_start_and_end
    validate_rows
  end

  private

  def print_row(row)
    row.map { |square| square.to_s }.join
  end

  def print_with_marks(row)
    row.map { |square| square.print }.join
  end

  def text_to_grid(text)
    text.split("\n").map do |row|
      row.chars.map { |char| Square.new(char) }
    end
  end

  def read_file(file)
    File.read(file)
  end

  def find_pos(type)
    grid.each_with_index do |row, y|
      row.each_with_index do |square, x|
        return Position.new(x, y) if square.send(type)
      end
    end

    raise "A position of type #{type} could not be found"
  end

  def each
    grid.flatten.each { |square| yield(square) }
  end

  def validate_characters
    contents = grid.flatten.map(&:content)
    unless (contents - ['E', ' ', '*', 'S']).empty?
      raise MazeError, "A maze file may only contain the characters 'E', '*', 'S', ' '"
    end
  end

  def validate_start_and_end
    contents = grid.flatten.map(&:content)
    unless contents.count('E') == 1 and contents.count('S') == 1
      raise MazeError, "There must be exactly one start and end square."
    end
  end

  def validate_rows
    unless grid.all? { |row| row.length == x_bound }
      raise MazeError, "Each row in a maze must have the same length"
    end
  end
end

class MazeError < StandardError; end

