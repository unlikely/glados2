require 'spec_helper'

describe Door do

  describe "Door should be saved when" do
    it "has non empty :name that is unique" do
      door = build(:door)
      door.should be_valid
    end
  end

  describe "Door should not be saved when" do
    it "has an empty :name" do
      door = build(:door)
      door.name = " "
      door.should_not be_valid
    end

    it "has a duplicate name" do
      door = create(:door)
      door2 = build(:door)
      door2.name = door.name
      door2.should_not be_valid
    end
  end

  describe "Door association" do
    it "has_many door_keys" do
      door = build(:door)
      door_key = build(:door_key)
      door.door_keys = [ door_key ]
    end
  end

  describe "permits entry_to?" do
    # how to improve name in meaningful way?
    it "has a fob authorized for a door" do
      door_key = create(:door_key)
      fob = build(:fob)
      fob.user = door_key.user
      fob.save
      door = door_key.door
      door.entry_to?(fob).should == true
    end
  end
#tired of typing.. how to write less then 70 lines of code for simple methods
   describe "rejects entry_to?" do
    it "for invalid :user" do
      user = create(:user)
      door_key = create(:door_key)
      fob = build(:fob)
      fob.user = user
      fob.save
      door = door_key.door
      door.entry_to?(fob).should be_false
    end

    it "for invalid :door" do
      door_key = create(:door_key)
      fob = build(:fob)
      fob.user = door_key.user
      fob.save
      door = create(:door)
      door.entry_to?(fob).should be_false
    end

    it "for invalid :fob" do
      door_key = create(:door_key)
      fob = create(:fob)
      door = door_key.door
      door.entry_to?(fob).should be_false
    end

# Unable to reproduce Scotts bug with empty database
    it "for invalid :door_key" do
      door = create(:door)
      user = create(:user)
      fob = create(:fob)
      door.entry_to?(fob).should be_false
    end
  end
end
