class User <ActiveRecord::Base
  attr_accessible :name

  has_many :door_keys
  has_many :fobs
  validates :name, :presence => true

end

