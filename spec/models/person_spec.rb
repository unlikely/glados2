require 'spec_helper'

describe Person do
  describe "saves when" do
    it ":name is non-empty" do
      people = Person.new(name: "name")
      people.should be_valid
    end
  end

  describe "does not save when" do
    it ":name is empty" do
      people = Person.new(name: " ")
      people.should_not be_valid
    end
  end

  describe "associations are present and" do
    it "has_many :fobs if a person has fobs" do
      person = Person.new(name: "name1")
      fob = Fob.new(key: "key1")
      fob2 = Fob.new(key: "key2")
      person.fobs = [ fob ]
      person.fobs << fob2
      person.fobs.should == [ fob, fob2 ]
    end

    it "has_many :door_keys if a person has access to a door" do
      person = Person.new(name: "name2")
      dk = DoorKey.new(person: person, door: Door.new(name: "doorname"))
      dk2 = DoorKey.new(person: person, door: Door.new(name: "doorname2"))
      person.door_keys = [ dk ]
      person.door_keys << [ dk2 ]
      person.door_keys.should == [ dk , dk2 ]
     end

    it "has_many :possession_contracts if a person owns :equipment" do
      person = Person.new(name: "new name")
      pos_contract  = PossessionContract.new(person: person, equipment: Equipment.create(make: "vw", model: "jetta"), contract_type: "a lease")
      pos_contract2 = PossessionContract.new(person: person, equipment: Equipment.create(make: "dewalt", model: "drill"), contract_type: "a lease")
      person.possession_contracts =  [ pos_contract ]
      person.possession_contracts << [ pos_contract2 ]
      person.possession_contracts.should == [ pos_contract, pos_contract2 ]
    end
  end

end
