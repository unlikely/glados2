require 'spec_helper'

describe ApplicationHelper do

  describe "lease_total_payments" do
    it "returns total lease amounts" do
      pos_contract = create(:possession_contract_with_lease)
      pos_contract2 = create(:possession_contract_with_lease)
      pos_contract3 = create(:possession_contract)
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
      pos_contract = create(:possession_contract)
      pos_contract2 = create(:possession_contract)
      people = [pos_contract.person, pos_contract2.person]
      contracts = helper.aggregate_possession_contracts(people)
      contracts.should include pos_contract
      contracts.should include pos_contract2
    end

    it "returns :possession_contracts [] if no possession_contracts" do
      helper.aggregate_possession_contracts(nil).should be_empty
    end
  end
end
