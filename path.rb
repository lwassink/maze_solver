#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


class Path
  include Enumerable
  attr_reader :positions

  def initialize(positions = nil)
    @positions = positions || []
  end

  def << array
    @positions << array
  end

  def remove_redundancies
    each { |pos| collapse(pos) if redundant?(pos) }
  end

  def ==(other)
    positions == other.positions
  end

  def to_s
    positions.to_s
  end

  def each
    positions.each { |pos| yield pos }
    self
  end

  private

  def redundant?(pos)
    positions.count(pos) > 1
  end

  def collapse(pos)
    occurrences = each_with_index.select { |p, i| p == pos }
    first = occurrences.first[1]
    last = occurrences.last[1]
    @positions = @positions[0...first] + @positions[last..-1]
  end
end
