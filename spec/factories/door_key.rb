require 'factory_girl'

FactoryGirl.define do
  factory :door_key do
    association :person
    association :door
  end
end
