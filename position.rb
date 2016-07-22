#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


class Position
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def up
    new = self.dup
    new.up!
  end

  def down
    new = self.dup
    new.down!
  end

  def right
    new = self.dup
    new.right!
  end

  def left
    new = self.dup
    new.left!
  end

  def ==(other)
    @x == other.x
    @y == other.y
  end

  protected

  def up!
    @y += 1
    self
  end

  def down!
    @y -= 1
    self
  end

  def right!
    @x += 1
    self
  end

  def left!
    @x -= 1
    self
  end
end

