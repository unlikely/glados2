require 'spec_helper'

describe Door do

  describe "Door should be saved when" do
    it "has non empty :name that is unique" do
      door = Door.new(name: "door1")
      door.should be_valid
    end
  end

  describe "Door should not be saved when" do
    it "has an empty :name" do
      door = Door.new
      door.should_not be_valid
    end

    it "has a duplicate name" do
      door1 = Door.create(name: "name2")
      door2 = Door.new(name: "name2")
      door2.should_not be_valid
    end
  end

  describe "Door association" do
    it "has_many door_keys" do
      door = Door.new(name: "name3")
      door_key = DoorKey.new(door: door, user:  User.new(name: "name1"))
      door.door_keys = [ door_key ]
    end
  end

  describe "permitting_entry_to?" do
    it "has a fob authorized for a door" do
      door = Door.new(name: "name4")
      user = User.new(name: "name2")
      door_key = DoorKey.create(door: door, user: user)
      fob = Fob.new(key: "poop3",user: user)
      door.permitting_entry_to?(fob).should be_true
    end

    it "is false for a wrong :user" do
      door = Door.new(name: "name5")
      user = User.new(name: "name3")
      door_key = DoorKey.create(door: door, user: User.new(name: "name4"))
      fob = Fob.new(key: "poop4",user: user)
      door.permitting_entry_to?(fob).should be_false
    end

    it "is false for a wrong :door" do
      door = Door.new(name: "name6")
      user = User.new(name: "name4")
      door_key = DoorKey.create(door: Door.new(name: "name7"), user: user)
      fob = Fob.new(key: "poop", user: user)
      door.permitting_entry_to?(fob).should be_false
    end

    it "is false for a wrong :fob" do
      door = Door.new(name: "name7")
      user = User.new(name: "name5")
      door_key = DoorKey.create(door: door, user: user)
      fob = Fob.new(key: "blalsb", user: User.new(name: "name6"))
      door.permitting_entry_to?(fob).should be_false
    end

# Unable to reproduce Scotts bug with empty database
    it "is false for wrong door_key" do
      door = Door.new(name: "name8")
      user = User.new(name: "name6")
      door_key = DoorKey.create(door: Door.new(name: "name9"), user: User.new(name: "name7"))
      fob = Fob.new(key: "asdblalsb", user: user)
      door.permitting_entry_to?(fob).should be_false
    end

    it "is false for missing user" do
      door = Door.new(name: "name9")
      fob = Fob.new(key: "monkeydo")
      door.permitting_entry_to?(fob).should be_false
      end
  end
end
