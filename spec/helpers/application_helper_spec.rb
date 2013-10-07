require 'spec_helper'

describe ApplicationHelper do

  describe "lease_total_payments" do
    it "returns total lease amounts" do
      person = Person.new(name: "lease testing name")
      date = Date.today
      equipment = Equipment.create(model: "amonkdye", make: "6/8")
      equipment2 = Equipment.create(model: "odb", make: "hand")
      equipment3 = Equipment.create(model: "third", make: "make3")
      pos_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "a lease", payment: 500, expires: '11/05/2013')
      pos_contract2 = PossessionContract.create(person: person, equipment: equipment2, contract_type: "a lease",payment: 65, expires: '09/05/2013')
      pos_contract3 = PossessionContract.create(person: person, equipment: equipment3, contract_type: "borrow",payment: 65)
      possession_contracts = PossessionContract.all
      lease_total_payments(possession_contracts).should == (pos_contract.payment + pos_contract2.payment)
    end

    it "returns 0 if no posession contracts" do
      possession_contracts = PossessionContract.all
      lease_total_payments(possession_contracts).should == 0
    end
  end

  describe "aggregate_possession_contracts" do

    it "assigns :possession_contracts with correct contracts" do
      person = Person.new(name: "lease testing name")
      person2 = Person.new(name: "new name")
      date = Date.today
      equipment = Equipment.create(model: "ape", make: "grand")
      equipment2 = Equipment.create(model: "ape2", make: "grand2")
      pos_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "a lease", payment: 500, expires: '11/05/2013')
      pos_contract2 = PossessionContract.create(person: person2, equipment: equipment2, contract_type: "a lease",payment: 65, expires: '09/05/2013')
      people = [person, person2]
      contracts = helper.aggregate_possession_contracts(people)
      contracts.should include pos_contract
      contracts.should include pos_contract2
    end

    it "returns :possession_contracts [] if no possession_contracts" do
      helper.aggregate_possession_contracts(nil).should be_empty
    end
  end
end
