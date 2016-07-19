#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#

require 'spec_helper'

describe Book do

  before :each do
    @book = Book.new("Title", "Author", :category)
  end

  describe "#new" do
    it "returns a new book object" do
      expect(@book).to be_an_instance_of Book
    end

    it "takes three parameters and returns a book object" do
      expect { Book.new("Title", "Author") }.to raise_error(ArgumentError)
    end
  end
end
