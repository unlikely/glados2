require 'spec_helper'

describe User do
# Feels useless? Just testing that Factory and model works
  describe "should be created when" do
    it ":name is non-empty" do
      user = FactoryGirl.build :user
      user.should be_valid
      p user.name
    end
  end

  describe "should fail creation when" do
    it ":name is empty" do
      user= User.new
      user.name = " "
      user.should_not be_valid
    end
  end

  describe "associations are present and could have_many" do
    it ":fobs if user has  fob" do
      user = User.new
      fob = Fob.new
      fob2 = Fob.new
      user.name = "sample name"
      user.fob = [ fob, fob2 ]
      user.should be_valid
    end
    it ":door_keys if user has access to a door" do
      user = User.new
      dk = DoorKey.new
      dk2 = DoorKey.new
      user.name = "sample name"
      user.door_keys = [ dk, dk2 ]
      user.should be_valid
    end
   end
  describe "associations fail if have_many" do
    it ":fobs added individually" do
      user = User.new
      a_fob = Fob.new
      user.name = "sample name"
      user.fobs = a_fob
      user.should_not be_valid
    end
    it ":door_keys added individually" do
      user = User.new
      a_dk = DoorKey.new
      user.name = "Sample name2"
      user.door_keys = a_dk
      user.should_not be_valid
    end
  end
end
