require 'spec_helper'

describe Door do

  describe "Door should be created when" do
    it "has non empty :name that is unique" do
      door = Door.new
      d.name = "a unique non empty name"
      d.should be_valid
    end
  end

  describe "Door should not be created when" do
    it "has an empty :name" do
      d = Door.new
      d.name = " "
      d.should_not be_valid
    end
  end

  it "has a duplicate name" do
    door = Door.new
    door.name = "name"
    door.save
    door2 = Door.new
    door2.name = "name"
    door2.should_not be_valid
  end

  it "has_many door_keys" do
  end
  
  it "permits entry_to? door"
    it "is false for wrong user"
    it "is false for wrong door"
    it "is false for wrong fob"
    it "does not return nil"
    it "does not take nil"
    it "given nil user should create fob"
end
