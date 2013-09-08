require 'spec_helper'

describe Agreement do
  describe "saves when" do
    it "has correct :name, :version and :author assigned" do
      agreement = build(:agreement)
      agreement.should be_valid
    end
  end

  describe "does not save when" do
    it "has empty :name" do
      agreement = build(:agreement, name: "")
      agreement.should_not be_valid
    end

    it "has empty :version" do
      agreement = build(:agreement, version: "")
      agreement.should_not be_valid
    end

    it "has non int :version" do
      agreement = build(:agreement, version: "hello")
      agreement.should_not be_valid
    end

    it "has empty :author" do
      agreement = build(:agreement, author: "")
      agreement.should_not be_valid
    end
    it "has wrong author type" do
      agreement = build(:agreement, author: "not allowed type")
      agreement.should_not be_valid
    end
  end

end
