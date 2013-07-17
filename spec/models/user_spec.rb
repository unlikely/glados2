require 'spec_helper'

describe User do
  describe "should save when" do
    it ":name is non-empty" do
      user = User.new(name: "name")
      user.should be_valid
    end
  end

  describe "should not save when" do
    it ":name is empty" do
      user = User.new(name: " ")
      user.should_not be_valid
    end
  end

  describe "associations are present and could have_many" do
    it ":fobs if user has fobs" do
      user = User.new(name: "name1")
      fob = Fob.new(key: "key1")
      fob2 = Fob.new(key: "key2")
      user.fobs = [ fob ]
      user.fobs << fob2
      user.fobs.should == [ fob, fob2 ]
    end

    it ":door_keys if user has access to a door" do
      user = User.new(name: "name2")
      dk = DoorKey.new(user: user, door: Door.new(name: "doorname"))
      dk2 = DoorKey.new(user: user, door: Door.new(name: "doorname2"))
      user.door_keys = [ dk ]
      user.door_keys << [ dk2 ]
      user.door_keys.should == [ dk , dk2 ]
     end
   end
end
