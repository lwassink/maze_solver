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
    small_grid = [[w,w,w,w],
                   [w,e,f,w],
                   [w,s,e.dup,w],
                   [w,w,w,w]]
    small_maze = Maze.new(small_grid)
    @solver = Solver.new(small_maze)

    line_grid = [[f,e.dup,s]]
    line_maze = Maze.new(line_grid)
    @line_solver = Solver.new(line_maze)

    impossible_grid = [[s, w, f]]
    impossible_maze = Maze.new(impossible_grid)
    @impossible_solver = Solver.new(impossible_maze)
  end

  describe "#new" do
    it "produces an instance of Solver" do
      expect(@solver).to be_an_instance_of(Solver)
    end
  end

  describe "#solve" do
    it "solves a small maze" do
      @solver.solve!
      expect(@solver.finish).to eq(Position.new(2,1))
    end

    it "#solves a maze with blank edges" do
      @line_solver.solve!
      expect(@line_solver.finish).to eq(Position.new(0,0))
    end

    it "#knows an impossible maze is impossible" do
      @impossible_solver.solve!
      expect(@impossible_solver.finish).to be_falsey
    end
  end
end

def new_square(content)
  Square.new(content)
end

