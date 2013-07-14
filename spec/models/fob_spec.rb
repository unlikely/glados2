require 'spec_helper'

describe Fob do
  # same question I had for another model.. here I'm  basically testing that my FG is working..but adding it as the pair to an empty 
  # not unique
  describe "Fob should be created when" do
    it "has non empty and unique key" do
      fob = build(:fob)
      fob.should be_valid
    end
  end

  describe "Fob creation fails when" do
    it "has an empty key" do
      fob = build(:fob)
      fob.key = " "
      fob.should_not be_valid
    end

   it "has a duplicate key" do
     fob = create(:fob)
     fob2 = build(:fob)
     fob2.key = fob.key
     fob2.should_not be_valid
   end
  end

  describe "Fob association" do
    it "belongs to a user" do
      user = build(:user)
      fob = build(:fob)
      fob.user = user
      fob.user.should == user
    end

    it "should still work with no user" do
      fob = build(:fob)
      fob.should be_valid
    end
  end
end
