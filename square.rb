#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


class Square
  attr_reader :content

  def initialize(content)
    @content = content
    @marked = false
  end

  def mark
    new = self.dup
    new.mark!
  end

  def unmark
    new = self.dup
    new.unmark!
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

  protected

  def mark!
    @marked = true
    self
  end

  def unmark!
    @mark = false
    self
  end
end
