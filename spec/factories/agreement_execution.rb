require 'factory_girl'

FactoryGirl.define do
  factory :agreement_execution do
   association :person
   association :agreement
   sequence(:date_signed) { |n| Date.today + n.day }
   sequence(:agreement_url) { |n| "http://blah#{n}.com" }
  end
end
