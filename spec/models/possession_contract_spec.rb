require 'spec_helper'

describe PossessionContract do
  describe "should save when" do
    it "has non_empty :type, :person and :equipment, :payment, :expires" do
      pos_contract = PossessionContract.new(type: "lease", payment: 500, expires: Date.today, person: Person.new(name: "tarti"), equipment: Equipment.new(model: "phillips", make: "norelco"))
      pos_contract.should be_valid
    end
  end

  describe "should not save when" do
    it "has empty :person" do
      pos_contract = PossessionContract.new(type: "sale", equipment: Equipment.new(model: "fire", make: "hydrant"))
      pos_contract.should_not be_valid
    end

    it "has empty :equipment" do
      pos_contract = PossessionContract.new(type: "borrow", person: Person.new(name: "nutella"))
      pos_contract.should_not be_valid
    end

    it "has empty :type" do
      pos_contract = PossessionContract.new(person: Person.new(name: "tarti"), equipment: Equipment.new(model: "altima", make: "nissan"))
      pos_contract.should_not be_valid
    end
    it "has a :type that's not in our list" do
      pos_contract = PossessionContract.new(type: "buy", person: Person.new(name: "tartella"), equipment: Equipment.new(model: "poopy", make: "head"))
      pos_contract.should_not be_valid
    end
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
