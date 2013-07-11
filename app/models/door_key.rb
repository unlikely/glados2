class DoorKey <ActiveRecord::Base

  belongs_to :door
  belongs_to :user
  validates :user, :presence => true
  validates :door, :presence => true
end
