require 'factory_girl'

FactoryGirl.define do
  factory :fob do
    sequence(:key) { Digest::MD5.hexdigest(rand.to_s) }
  end
end
