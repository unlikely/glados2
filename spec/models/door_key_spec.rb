require 'spec_helper'

describe DoorKey do

  describe "should be created when" do
    it ":user and :door are non-empty" do
      door_key = DoorKey.new
      door_key.user_id = 1
      door_key.door_id = 1
      door_key.should be_valid
    end
  end

  describe "door_keys should not be saved when" do
    it ":user is empty" do
      door_key = DoorKey.new
      door_key.user_id = 1
      door_key.should_not be_valid
    end

    it ":door is empty"do
      door_key = DoorKey.new
      door_key.door = Door.create
      door_key.should_not be_valid
    end
  end

  it "belongs_to :user" do

  end

  it "belongs_to :door" do

  end
end
