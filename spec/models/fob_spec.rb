require 'spec_helper'

describe Fob do
  describe "Fob should be created when" do
    it "has non empty and unique key" do
      fob = Fob.new(key: "monkey")
      fob.should be_valid
    end
  end

  describe "Fob creation fails when" do
    it "has an empty key" do
      fob = Fob.new(key: "")
      fob.should_not be_valid
    end

   it "has a duplicate key" do
     fob = Fob.create(key: "key1")
     fob2 = Fob.new(key: "key1")
     fob2.should_not be_valid
   end
  end

  describe "Fob association" do
    it "belongs to a user" do
      user = User.new(name: "name1")
      fob = Fob.new(key: "key2", user: user)
      fob.user.should == user
    end

    it "should still work with no user" do
      fob = Fob.new(key: "poop")
      fob.should be_valid
    end
  end
end
