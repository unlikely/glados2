require 'factory_girl'

FactoryGirl.define do
  factory :agreement do
    sequence(:name, 1000) {|n| "Agreement#{n}"}
    sequence(:version, 20)
    author "Counsel"
  end
end
