#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#

require 'spec_helper'

RSpec.describe Square do
  before :each do
    @wall = Square.new('*')
    @empty_space = Square.new(' ')
    @start = Square.new('S')
    @finish = Square.new('E')
    @squares = [@wall, @empty_space, @start, @finish]
  end

  describe "#new" do
    it "is a Square" do
      @squares.each do |square|
        expect(square).to be_an_instance_of(Square)
      end
    end
  end

  describe "#wall?" do
    it "recognizes walls" do
      expect(@wall.wall?).to be true

      (@squares - [@wall]).each do |square|
        expect(square.wall?).to be false
      end
    end
  end

  describe "#start?" do
    it "recognizes the start" do
      expect(@start.start?).to be true

      (@squares - [@start]).each do |square|
        expect(square.start?).to be false
      end
    end
  end

  describe "#finish?" do
    it "recognizes the finish" do
      expect(@finish.finish?).to be true

      (@squares - [@finish]).each do |square|
        expect(square.finish?).to be false
      end
    end
  end

  describe "#empty?" do
    it "recognizes empty spaces" do
      expect(@wall.empty?).to be false

      (@squares - [@wall]).each do |square|
        expect(square.empty?).to be true
      end
    end
  end

  describe "#to_s" do
    it "turns an empty square into a string" do
      expect(@empty_space.to_s).to eq(' ')
    end

    it "turns a wall square into a string" do
      expect(@wall.to_s).to eq('*')
    end

    it "turns a start square into a string" do
      expect(@start.to_s).to eq('S')
    end

    it "turns an end square into a string" do
      expect(@finish.to_s).to eq('E')
    end
  end

  describe "#print" do
    it "prints ' ' for a blank square" do
      expect(@empty_space.print).to eq(' ')
    end

    it "prints 'X' for a marked square" do
      marked_space = @empty_space.mark
      expect(marked_space.print).to eq('X')
    end
  end
end
