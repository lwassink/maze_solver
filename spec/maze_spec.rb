#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#

require 'spec_helper'

RSpec.describe Maze do
  before :each do
    @empty_maze = Maze.new
    f = Square.new('E')
    s = Square.new('S')
    w = Square.new('*')
    e = Square.new(' ')
    m = Square.new(' ').mark
    @empty_grid = [[Square.new(' ')]]
    @small_grid = [[w,w,w,w],
                   [w,e,f,w],
                   [w,s,e,w],
                   [w,w,w,w]]
    @small_maze = Maze.new(@small_grid)
    @small_maze_text = "****\n* E*\n*S *\n****"
    @marked_maze = Maze.new([[e, m]])
  end

  describe "#new" do
    it "is a maze object" do
      expect(@empty_maze).to be_an_instance_of Maze
    end
  end

  describe "#grid" do
    context "given an empty maze" do
      it "returns a grid" do
        expect(@empty_maze.grid).to eq(@empty_grid)
      end
    end

    context "given a small maze" do
      it "returns a small grid" do
        expect(@small_maze.grid).to eq @small_grid
      end
    end
  end

  describe "#to_s" do
    context "given an empty maze" do
      it "prints an empty grid" do
        empty_output = ' '
        expect(@empty_maze.to_s).to eq(empty_output)
      end
    end

    context "given a small maze" do
      it "prints the grid of a small maze" do
        small_output = @small_maze_text
        expect(@small_maze.to_s).to eq(small_output)
      end
    end
  end

  describe "#read_text" do
    it "reads in a text file and updates the grid" do
      allow(File).to receive(:read).and_return(@small_maze_text)
      @empty_maze.read_text('test')
      expect(@empty_maze).to eq(@small_maze)
    end
  end

  describe "#[]" do
    it "reads @small_maze[0, 1] as a wall" do
      expect(@small_maze[0,1].wall?).to be true
    end

    it "reads @small_maze[2, 1] as the end" do
      expect(@small_maze[2,1].finish?).to be true
    end
  end

  describe "#start" do
    it "returns the starting position of a maze that has one" do
      expect(@small_maze.start).to eq(Position.new(1,2))
    end

    it "raises an error if there is no start" do
      expect { @empty_maze.start } .to raise_error(StandardError)
    end
  end

  describe "#xbound" do
    it "returns the length of a row in a maze" do
      expect(@small_maze.x_bound).to eq(4)
    end
  end

  describe "#ybound" do
    it "returns of length of a column in a maze" do
      expect(@small_maze.y_bound).to eq(4)
    end
  end

  describe "#print" do
    it "prints squares with marks" do
      expect(@marked_maze.print).to eq(" X")
    end
  end

  describe "#reset" do
    it "resets the marks on a marked maze" do
      @marked_maze.reset_marks
      expect(@marked_maze.print).to eq(" X")
    end
  end
end

