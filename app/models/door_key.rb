class DoorKey <ActiveRecord::Base
  attr_accessible :person, :door

  belongs_to :door
  belongs_to :person
  validates :person, :presence => true
  validates :door, :presence => true
end
