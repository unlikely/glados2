require 'spec_helper'

describe Equipment do
  describe "should be saved when" do
    it "has :model, :replacement_cost, :make, and :serial_number information" do
      equip = Equipment.new(model: "phillips head", make: "B & D", serial_number: "acasdasdf", replacement_cost: 30)
      equip.should be_valid
    end

    it "has non_empty :model and :make but empty :replacement_cost, :serial_number information" do
      equip = Equipment.new(model: "phillips head2", make: "db3")
      equip.should be_valid
    end
  end

  describe "should not save when" do
    it "has empty :model" do
      equip = Equipment.new(model: " ", make: "Jose")
      equip.should_not be_valid
    end

    it "has empty :make" do
      equip = Equipment.new(model: "sander", make: " ")
      equip.should_not be_valid
    end
  end

  describe "associations" do
    it "save when has one :possession_contract" do
      equip = Equipment.new(model: "sander2", make: "jose")
      pos_contract = PossessionContract.new(equipment: equip, person: Person.new(name: "idon't care")) 
      equip.possession_contract = equip
    end

    it "fail when has more than one :possession_contract" do
      equip = Equipment.new(model: "laser cutter", make: "full spectrum")
      equip2 = Equipment.new(model: "3d printer", make: "ultimaker")
      pos_contract = PossessionContract.new(equipment: equip, person: Person.new(name: "idk2"))
      pos_contract.equipment << equip2
      pos_contract.should_not be_valid
    end
  end
end
