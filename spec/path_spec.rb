#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#

require 'spec_helper'

describe Path do
  before :each do
    @path = Path.new
    redudant_positions = [[1,1], [1,2], [1,3], [1,4], [1,3], [1,2], [2,2]]
    @redundant_path = Path.new(redudant_positions)
    non_redundant_positions = [[1,1], [1,2], [2,2]]
    @non_redundant_path = Path.new(non_redundant_positions)
  end

  describe "#new" do
    it "creates a new path" do
      expect(@path).to be_an_instance_of(Path)
    end
  end

  describe "#positions" do
    context "given an empty path" do
      it "it is empty" do
        expect(@path.positions).to eq([])
      end
    end
  end

  describe "#<<" do
    context "given an empty path" do
      it "adds the position" do
        @path << [1,1]
        expect(@path.positions).to eq([[1,1]])
      end
    end
  end

  describe "#remove_redundancies!" do
    context "given a path with redundancies" do
      it "removes the redundancies" do
        expect(@redundant_path.remove_redundancies!).to eq(@non_redundant_path)
      end
    end

    context "given a path without redundancies" do
      it "does nothing" do
        expect(@non_redundant_path.remove_redundancies!).to eq(@non_redundant_path)
      end
    end
  end
end

