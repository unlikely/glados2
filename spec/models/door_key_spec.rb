require 'spec_helper'

describe DoorKey do

  describe "should be created when" do
    it ":user and :door are non-empty" do
      door_key = FactoryGirl.build :door_key 
      door_key.should be_valid
    end
  end

# Testing to see if the join table takes a nil.. should I test empty too?
  describe "door_keys should not be saved when" do
    it ":user is nil" do
      door_key = FactoryGirl.build :door_key
      door_key.user_id = nil
      door_key.should_not be_valid
    end

    it ":door is nil"do
      door_key = FactoryGirl.build :door_key
      door_key.door_id = nil
      door_key.should_not be_valid
    end
  end

  # I have a question for this one.. by doing the first test I do the belongs_to and I'm checking that if one is nil doesn't save
  it "belongs_to :user" do

  end

  it "belongs_to :door" do

  end
end
