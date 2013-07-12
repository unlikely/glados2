require 'spec_helper'

describe Fob do
  # same question I had for last model spec.. basically testing that my FG is working..
  describe "Fob should be created when" do
    it "has non empty and unique key" do
      fob = build(:fob)
    end
  end

  describe "Fob creation fails when"do

    it "has an empty key" do
      fob = build(:fob)
      fob.key = " "
      fob.should_not be_valid
    end
  end

  describe "Fob association" do
    it "belongs to a user" do
      user = build(:user)
      fob = build(:fob)
      fob.user = user
      fob.user.should == user
    end
  end
end
