require 'spec_helper'

describe Fob do
  # same question I had for last model spec.. wow plus super dizzy.. need to stop makes no sense now.. counter was fast
  describe "Fob should be created when" do
  it "has non empty and unique key" do
    fob = FactoryGirl.build :fob
  end
  end
  describe "Fob creation fails when"
    it "has an empty key"
    it "has a non-unique key"

  describe "Fob associations belong"
  it "belongs to user"


end
