require 'factory_girl'

FactoryGirl.define do
  factory :door do
    sequence(:name, 10000 ) { |n| "First Last#{n}" }
  end
end
