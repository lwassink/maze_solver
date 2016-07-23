#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


class Direction
  attr_reader :dir

  @@directions = [:up, :right, :down, :left]

  def initialize(dir)
    @dir = dir
  end

  def turn_right!
    @dir = turn(:right).dir
    self
  end

  def turn_left!
    @dir = turn(:left).dir
    self
  end

  def turn(turn)
    offsets = { front: 0, right: 1, back: 2, left: 3 }
    offset = offsets[turn]
    current_index = @@directions.index(dir)
    new_index = (current_index + offset) % 4
    Direction.new(@@directions[new_index])
  end

  def ==(other)
    dir == other.dir
  end

  def to_s
    dir.to_s
  end

  def to_sym
    dir
  end
end

