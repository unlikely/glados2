require 'spec_helper'

describe User do
# Feels useless? Just testing that Factory and model works
  describe "should save when" do
    it ":name is non-empty" do
      user = build(:user)
      user.should be_valid
    end
  end

  describe "should not save when" do
    it ":name is empty" do
      user= build(:user)
      user.name = " "
      user.should_not be_valid
    end
  end

# We discussed only including one test.. probably overkill to do the multiple inputs..
  describe "associations are present and could have_many" do
    it ":fobs if user has fob" do
      user = build(:user)
      fob = build(:fob)
      fob2 = build(:fob)
      user.fobs = [ fob ]
      user.fobs << fob2
      user.fobs.should == [ fob, fob2 ]
    end

    it ":door_keys if user has access to a door" do
      user = build(:user)
      dk = build(:door_key)
      dk2 = build(:door_key)
      user.door_keys = [ dk ]
      user.door_keys << [ dk2 ]
      user.door_keys.should == [ dk , dk2 ]
     end
   end
end
