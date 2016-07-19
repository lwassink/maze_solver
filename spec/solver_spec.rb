#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#

require 'spec_helper'

describe Solver do
  before :each do
    f = new_square('E')
    s = new_square('S')
    w = new_square('*')
    e = new_square(' ')
    @empty_grid = [[new_square(' ')]]
    @small_grid = [[w,w,w,w],
                   [w,e,f,w],
                   [w,s,e,w],
                   [w,w,w,w]]
    @small_maze = Maze.new(@small_grid)
    @solver = Solver.new(@small_maze)
    @solved_path = Path.new([[1,2], [2,2], [2,1]])
  end

  describe "#new" do
    it "produces an instance of Solver" do
      expect(@solver).to be_an_instance_of(Solver)
    end
  end

  describe "#solve" do
    it "solves a small maze" do
      @solver.solve
      expect(@solver.path).to eq(@solved_path)
    end
  end
end

def new_square(content)
  Maze::Square.new(content)
end
