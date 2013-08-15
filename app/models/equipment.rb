class Equipment < ActiveRecord::Base
  attr_accessible :model, :make, :serial_number, :replacement_cost

  validates :model, :presence => true
  validates :make, :presence => true
  validates_numericality_of :replacement_cost, :only_integer => true, :allow_blank => true
end
