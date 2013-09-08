require 'spec_helper'

describe DoorKey do

  describe "should save when" do
    it "has non-empty :person and :door" do
      person = Person.new(name: "name")
      door = Door.new(name: "a door")
      door_key = DoorKey.new(person: person, door: door)
      door_key.should be_valid
    end
  end

  describe "door_keys should not save when" do
    it ":person is empty" do
      door = Door.new(name: "a door2")
      door_key = DoorKey.new(door: door)
      door_key.should_not be_valid
    end

    it ":door is empty" do
      person = Person.new(name: "name2")
      door_key = DoorKey.new(person: person)
      door_key.should_not be_valid
    end
  end

  describe "DoorKey association" do
    it "belongs_to :person" do
      person = Person.new(name: "name3")
      door = Door.new(name: "a door3")
      door_key = DoorKey.new(person: person, door: door)
      door_key.person.should == person
    end

    it "belongs_to :door" do
      person = Person.new(name: "name4")
      door = Door.new(name: "a door4")
      door_key = DoorKey.new(person: person, door: door)
      door_key.door.should == door
    end
  end
end
