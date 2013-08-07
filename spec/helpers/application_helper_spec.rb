require 'spec_helper'

describe ApplicationHelper do
   describe "#dollars_to_cents" do
      it "should return number * 100" do
        mynumber = 23.5
        dollars_to_cents(mynumber).should == mynumber * 100
      end
   end

  describe "count_equipment_owned" do
    it "returns correct count given :people" do
      person1 = Person.new(name: "testing name1")
      person2 = Person.new(name: "testing name2")
      equipment = Equipment.new(model: "drill", make: "3/8")
      equipment2 = Equipment.new(model: "drill2", make: "5/9")
      pos_contract = PossessionContract.create(person: person1, equipment: equipment, contract_type: "lease")
      pos_contract2 = PossessionContract.create(person: person2, equipment: equipment2, contract_type: "lease")
      people = Person.all
      count_equipment_owned(people).should == 2
    end
  end

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
      people = Person.all
      lease_total_payments(people).should == (pos_contract.payment + pos_contract2.payment)
    end
  end

end
