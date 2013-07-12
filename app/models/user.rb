class User <ActiveRecord::Base

  has_many :door_keys
  has_many :fobs
  validates :name, :presence => true

end

