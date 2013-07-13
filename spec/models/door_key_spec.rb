require 'spec_helper'

describe DoorKey do

  describe "should save when" do
    it ":user and :door are non-empty" do
      door_key = build(:door_key)
      door_key.should be_valid
    end
  end

# Testing to see if the join table takes a nil.. should I test empty too?
  describe "door_keys should not save when" do
    it ":user is empty" do
      door_key = build(:door_key)
      door_key.user_id = " "
      door_key.should_not be_valid
    end

    it ":door is empty" do
      door_key = build(:door_key)
      door_key.door_id = " "
      door_key.should_not be_valid
    end
  end

  describe "DoorKey association" do
    it "belongs_to :user" do
      user = build(:user)
      door_key = build(:door_key)
      door_key.user = user
      door_key.user.should == user
    end

    it "belongs_to :door" do
      door = build(:door)
      door_key = build(:door_key)
      door_key.door = door
      door_key.door.should == door
    end
  end
end
