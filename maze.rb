#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


require_relative 'path'

class Maze
  attr_reader :grid

  def initialize(grid = nil)
    @grid = grid || [[Square.new(' ')]]
  end

  def [](x, y)
    grid[y][x]
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
    grid.length
  end

  def y_bound
    grid[0].length
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
    x, y = pos
    x < 0 || x_bound <= x || y < 0 || y_bound <= y
  end

  def reset_marks
    each { |square| square.unmark }
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
      row.each_with_index { |square, x| return [x, y] if square.send(type) }
    end

    raise "A position of type #{type} could not be found"
  end

  def each
    grid.flatten.each { |square| yield(square) }
  end

  class Square
    attr_reader :content

    def initialize(content)
      @content = content
      @marked = false
    end

    def mark
      @marked = true
      self
    end

    def unmark
      @mark = false
    end

    def wall?
      content == '*'
    end

    def start?
      content == 'S'
    end

    def finish?
      content == 'E'
    end

    def empty?
      !self.wall?
    end

    def marked?
      @marked
    end

    def ==(other)
      content == other.content
    end

    def to_s
      content
    end

    def print
      marked? ? 'X' : self.to_s
    end
  end
end
