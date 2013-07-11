require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:name, 10000) { |n| "Door Name#{n}" }
  end
end
