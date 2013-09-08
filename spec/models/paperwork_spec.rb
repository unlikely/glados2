require 'spec_helper'

describe Paperwork do
  describe "saves when" do
    it "has correct :name, :version and :author assigned" do
      paperwork = build(:paperwork)
      paperwork.should be_valid
    end
  end

  describe "does not save when" do
    it "has empty :name" do
      paperwork = build(:paperwork, name: "")
      paperwork.should_not be_valid
    end

    it "has empty :version" do
      paperwork = build(:paperwork, version: "")
      paperwork.should_not be_valid
    end

    it "has non int :version" do
      paperwork = build(:paperwork, version: "hello")
      paperwork.should_not be_valid
    end

    it "has empty :author" do
      paperwork = build(:paperwork, author: "")
      paperwork.should_not be_valid
    end
    it "has wrong author type" do
      paperwork = build(:paperwork, author: "not allowed type")
      paperwork.should_not be_valid
    end
  end

    describe "associations" do
      it "saves when has_many :agreement_executions"

    end
end
