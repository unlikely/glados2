require 'factory_girl'

FactoryGirl.define do
  factory :paperwork do
    sequence(:name, 1000) {|n| "Paperwork#{n}"}
    sequence(:version, 20)
    author "Counsel"
  end
end
