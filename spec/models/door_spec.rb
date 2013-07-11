require 'spec_helper'

describe Door do

  describe "Door should be created when" do
    it "has non empty :name that is unique" do
      door = FactoryGirl.build :door
      door.should be_valid
    end
  end

  describe "Door should not be created when" do
    it "has an empty :name" do
      door = FactoryGirl.build :door
      door.name = " "
      door.should_not be_valid
    end
  end

  it "has a duplicate name" do
    door = FactoryGirl.build :door
    door.save
    door2 = FactoryGirl.build :door
    door2.name = door.name
    door2.should_not be_valid
  end

  it "has_many door_keys" do
    door = FactoryGirl.build :door 
    door_key = FactoryGirl.build :door_key
    door.door_keys = [ door_key ]
  end

  it "permits entry_to? door"
    it "is false for wrong user"
    it "is false for wrong door"
    it "is false for wrong fob"
    it "does not return nil"
    it "does not take nil"
    it "given nil user should create fob"
end
