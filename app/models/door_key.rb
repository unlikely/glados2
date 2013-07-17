class DoorKey <ActiveRecord::Base
  attr_accessible :user, :door

  belongs_to :door
  belongs_to :user
  validates :user, :presence => true
  validates :door, :presence => true
end
