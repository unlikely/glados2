require 'spec_helper'

describe PossessionContract do
  describe "should be saved when" do
    it "has non_empty type, :person and :equipment" do
      pos_contract = PossessionContract.new(type: "lease", person: Person.new(name: "tarti"), equipment: Equipment.new(model: "phillips", make: "norelco"))
      pos_contract.should be_valid
    end
  end

  describe "should not save when" do
    it "has empty :person"
    it "has empty :equipment"
    it "has empty :type"
  end

  describe "associations" do
    it "belongs_to :person" do
      person = Person.new(name: "p1")
      equip = Equipment.new(make: "norelco", model: "razer")
      pos_contract = PossessionContract.new(type: "lease", person: person, equipment: equip)
      pos_contract.person.should == person
    end

    it "belongs_to :equipment" do
      person = Person.new(name: "p2")
      equip = Equipment.new(make: "vw", model: "golf")
      pos_contract = PossessionContract.new(type: "buy", person: person, equipment: equip)
      pos_contract.equipment.should == equip

    end
  end
end
