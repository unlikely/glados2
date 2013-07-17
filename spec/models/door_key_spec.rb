require 'spec_helper'

describe DoorKey do

  describe "should save when" do
    it "has non-empty :user and :door" do
      user = User.new(name: "name")
      door = Door.new(name: "a door")
      door_key = DoorKey.new(user: user, door: door)
      door_key.should be_valid
    end
  end

# Testing to see if the join table takes a nil.. should I test empty too?
  describe "door_keys should not save when" do
    it ":user is empty" do
      door = Door.new(name: "a door2")
      door_key = DoorKey.new(door: door)
      door_key.should_not be_valid
    end

    it ":door is empty" do
      user = User.new(name: "name2")
      door_key = DoorKey.new(user: user)
      door_key.should_not be_valid
    end
  end

  describe "DoorKey association" do
    it "belongs_to :user" do
      user = User.new(name: "name3")
      door = Door.new(name: "a door3")
      door_key = DoorKey.new(user: user, door: door)
      door_key.user.should == user
    end

    it "belongs_to :door" do
      user = User.new(name: "name4")
      door = Door.new(name: "a door4")
      door_key = DoorKey.new(user: user, door: door)
      door_key.door.should == door
    end
  end
end
