require 'factory_girl'

FactoryGirl.define do
  factory :fob do
    association :user
    sequence(:key) { Digest::MD5.hexdigest(rand.to_s) }
  end
end
