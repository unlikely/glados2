class Door < ActiveRecord::Base
  has_many :door_keys
  validates :name, :presence => true, :uniqueness => true
end
