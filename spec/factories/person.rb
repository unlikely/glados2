require 'factory_girl'

FactoryGirl.define do
  factory :person do
    sequence(:name, 10000) { |n| "David Clone #{n}" }
  end
end
