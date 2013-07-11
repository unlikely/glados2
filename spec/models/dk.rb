require 'spec_helper'

describe DoorKey do

  describe "door_keys should be created when" do
    it "has a non-empty :user and non-empty :door" do
      door_key = DoorKey.new(user_id: 1, door_id: 1)
      door_key.should be_valid
    end
  end

  describe "door_keys should not be created when" do
    it "has an empty :user" do

    end

    it "has an empty :door"do

    end
  end

  it "belongs_to :user" do

  end

  it "belongs_to :door" do

  end
end
