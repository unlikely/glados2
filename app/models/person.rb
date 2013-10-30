class Person <ActiveRecord::Base
  attr_accessible :name

  has_many :possession_contracts
  has_many :equipment, through: :possession_contracts
  has_many :door_keys
  has_many :doors, through: :door_keys
  has_many :fobs
  has_many :agreement_executions
  has_many :agreements, through: :agreement_executions
  validates :name, :presence => true

end

