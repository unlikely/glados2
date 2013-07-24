class Equipment < ActiveRecord::Base
  attr_accessible :model, :make, :serial_number, :replacement_cost

  validates :model, :presence => true
  validates :make, :presence => true
end
