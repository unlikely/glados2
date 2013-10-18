require 'factory_girl'

FactoryGirl.define do
  factory :possession_contract do
    association :person
    association :equipment
    contract_type "borrow"
  end

  factory :possession_contract_with_lease, parent: :possession_contract do
    contract_type "a lease"
    expires Date.today.strftime("%Y-%m-%d")
    start_date (Date.today - 60.days).strftime("%Y-%m-%d")
    payment_cents 300
  end
end
