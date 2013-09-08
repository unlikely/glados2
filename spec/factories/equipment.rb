require 'factory_girl'

FactoryGirl.define do
  factory :equipment do
    sequence(:model, 1000){|n| "Model {n}"}
    sequence(:make, 1000){|n| "Make {n}"}
    sequence(:serial_number, 1000){|n| "Serial{n}"}
    sequence(:replacement_cost, 1000)
  end
end
