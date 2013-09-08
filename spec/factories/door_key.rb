require 'factory_girl'

FactoryGirl.define do
  factory :door_key do
    association :user
    association :door
  end
end
