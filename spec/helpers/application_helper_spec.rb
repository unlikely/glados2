require 'spec_helper'

describe ApplicationHelper do

  describe "lease_total_payments" do
    it "returns total lease amounts" do
      person = Person.new(name: "lease testing name")
      date = Date.today
      equipment = Equipment.new(model: "amonkdye", make: "6/8")
      equipment2 = Equipment.new(model: "odb", make: "hand")
      equipment3 = Equipment.new(model: "third", make: "make3")
      pos_contract = PossessionContract.create(person: person, equipment: equipment, contract_type: "lease", payment: 500, expires: '11/05/2013')
      pos_contract2 = PossessionContract.create(person: person, equipment: equipment2, contract_type: "lease",payment: 65, expires: '09/05/2013')
      pos_contract3 = PossessionContract.create(person: person, equipment: equipment3, contract_type: "borrow",payment: 65)
      possession_contracts = PossessionContract.all
      lease_total_payments(possession_contracts).should == (pos_contract.payment + pos_contract2.payment)
    end

    it "returns 0 if no posession contracts" do
      possession_contracts = PossessionContract.all
      lease_total_payments(possession_contracts).should == 0
    end
  end
end
