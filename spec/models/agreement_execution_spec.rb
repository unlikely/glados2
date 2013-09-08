require 'spec_helper.rb'

describe AgreementExecution do
  describe "saves when" do
    it "has non-empty :person, :agreement, :date_signed, :agreement_url" do
      agreement_execution = build(:agreement_execution)
      agreement_execution.should be_valid
    end
  end

  describe "doesn't save when" do
    it "has non_existant :person" do
      agreement_execution = build(:agreement_execution, person_id: 99999999)
      p agreement_execution
      agreement_execution.should_not be_valid
    end

    it "has empty :agreement" do
      agreement_execution = build(:agreement_execution, agreement_id: 9999999999)
      agreement_execution.should_not be_valid
    end

    it "has empty :date_signed" do
      agreement_execution = build(:agreement_execution, date_signed: "")
      agreement_execution.should_not be_valid
    end

    it "has wrong :date_signed" do
      agreement_execution = build(:agreement_execution, date_signed: "20013")
      agreement_execution.should_not be_valid
    end

    it "has empty :agreement_url" do
      agreement_execution = build(:agreement_execution, agreement_url: "")
      agreement_execution.should_not be_valid
    end

    it "has non-url in :agreement_url" do
      agreement_execution = build(:agreement_execution, agreement_url: "blahblah")
      agreement_execution.should_not be_valid
    end

    it "has non-unique url in agreement_url" do
      agreement_execution = create(:agreement_execution)
      agreement_execution1 = build(:agreement_execution, agreement_url: agreement_execution.agreement_url)
      agreement_execution1.should_not be_valid
    end
  end

end


