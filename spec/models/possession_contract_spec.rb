require 'spec_helper'

describe PossessionContract do
  describe "should save when" do
    it "has non_empty :contract_type, :person and :equipment, integer :payment, :expires" do
      pos_contract = PossessionContract.new(contract_type: "sale", payment_cents: 10, expires: Date.today, person: Person.new(name: "tarti"), equipment: Equipment.new(model: "phillips", make: "norelco"))
      pos_contract.should be_valid
    end

    it "has all non_empty fields AND :contract_type is lease and has :expires, :payments filled" do
      pos_contract = PossessionContract.new(contract_type: "lease", payment: 500, expires: Date.today, person: Person.new(name: "ssarti"), equipment: Equipment.new(model: "some companys", make: "razor"))
      pos_contract.should be_valid
     end
  end

  describe "should not save when" do
    it "has empty :person" do
      pos_contract = PossessionContract.new(contract_type: "sale",
                       equipment: Equipment.new(model: "fire", make: "hydrant"))
      pos_contract.should_not be_valid
    end

    it "has non integer :payment" do
      pos_contract = PossessionContract.new(payment_cents: 500.79, contract_type: "lease", person: Person.new(name: "wildfire"), equipment: Equipment.new(model: "hydrant", make: "fire"))
    end

    it "has empty :equipment" do
      pos_contract = PossessionContract.new(contract_type: "borrow", person: Person.new(name: "nutella"))
      pos_contract.should_not be_valid
    end

    it "has empty :contract_type" do
      pos_contract = PossessionContract.new(person: Person.new(name: "tarti"), equipment: Equipment.new(model: "altima", make: "nissan"))
      pos_contract.should_not be_valid
    end

    it "has :contract_type lease but no :expires" do
      person = Person.new(name: "david")
      equipment = Equipment.new(make: "husky", model: "drill")
      possession_contract = PossessionContract.new(person: person,
                                                   equipment: equipment, contract_type: "lease",
                                                   payment: 500)
      possession_contract.should_not be_valid
    end

    it "has :contract_type lease but no :payment" do
      person = Person.new(name: "davidi2")
      equipment = Equipment.new(make: "husky", model: "drawers")
      possession_contract = PossessionContract.create(person: person,
                                                   equipment: equipment, contract_type: "lease",
                                                   expires: Date.today)
      possession_contract.should_not be_valid
    end

    it "has a :contract_type that's not in our list" do
      pos_contract = PossessionContract.new(contract_type: "buy",
                                            person: Person.new(name: "tartella"),
                                            equipment: Equipment.new(model: "poopy", make: "head"))
      pos_contract.should_not be_valid
    end
  end

  describe "associations" do
    it "belongs_to :person" do
      person = Person.new(name: "p1")
      equip = Equipment.new(make: "norelco", model: "razer")
      pos_contract = PossessionContract.new(contract_type: "lease", person: person, equipment: equip)
      pos_contract.person.should == person
    end

    it "belongs_to :equipment" do
      person = Person.new(name: "p2")
      equip = Equipment.new(make: "vw", model: "golf")
      pos_contract = PossessionContract.new(contract_type: "sale", person: person, equipment: equip)
      pos_contract.equipment.should == equip
    end
  end

  describe "currency helpers" do
    it "payment converts cents to dollars" do
      a_payment = 505
      person = Person.new(name: "person")
      equip = Equipment.new(make: "vw", model: "golfette")
      pos_contract = PossessionContract.create(contract_type: "lease",
                      expires: Date.today, payment_cents: a_payment,
                      person: person, equipment: equip)
      pos_contract.payment.should == (a_payment.to_f / 100)
    end

    it "payment converts dollars to cents on save" do
      a_payment = 50.5
      person = Person.new(name: "person")
      equip = Equipment.new(make: "poop", model: "jetta")
      pos_contract = PossessionContract.create(contract_type: "lease",
                                            expires: Date.today, payment: a_payment,
                                            person: person, equipment: equip)
      pos_contract.payment_cents.should == (a_payment * 100).to_i
    end
  end
end
