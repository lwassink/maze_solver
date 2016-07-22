#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


require 'spec_helper'

describe Direction do
  before :each do
    @up = Direction.new(:up)
    @right = Direction.new(:right)
    @down = Direction.new(:down)
    @left = Direction.new(:left)
    @directions = [@up, @right, @down, @left]
  end

  describe "#new" do
    it "creates a new instance of Direction" do
      @directions.each do |dir|
        expect(dir).to be_an_instance_of(Direction)
      end
    end
  end

  describe "#turn_right!" do
    it "turns from up to right" do
      expect(@up.turn_right!).to eq(@right)
    end

    it "turns from left to up" do
      expect(@left.turn_right!).to eq(@up)
    end
  end

  describe "#turn" do
    it "shows down is to the back of up" do
      expect(@up.turn(:back)).to eq(@down)
    end

    it "shows up is to the left of right" do
      expect(@right.turn(:left)).to eq(@up)
    end
  end
end

