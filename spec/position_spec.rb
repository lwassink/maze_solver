#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#

require 'spec_helper'

describe Position do
  before :each do
    @pos = Position.new(1,1)
    @pos_up = Position.new(1,0)
    @pos_down = Position.new(1,2)
    @pos_left = Position.new(0,1)
    @pos_right = Position.new(2,1)
  end

  describe "#new" do
    it "creates a new Position object" do
      expect(@pos).to be_an_instance_of(Position)
    end
  end

  describe "#move" do
    it "moves the position up one unit" do
      expect(@pos.move(:up)).to eq(@pos_up)
    end

    it "moves the position down one unit" do
      expect(@pos.move(:down)).to eq(@pos_down)
    end

    it "moves the position right one unit" do
      expect(@pos.move(:right)).to eq(@pos_right)
    end

    it "moves the position left one unit" do
      expect(@pos.move(:left)).to eq(@pos_left)
    end
  end

  describe "#==" do
    it "checks of two positions are equal" do
      expect(@pos).to eq(Position.new(1,1))
    end
  end
end

