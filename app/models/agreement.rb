class Agreement < ActiveRecord::Base
  ALL_AUTHOR_TYPES = [
    COUNSEL   = "Counsel",
    MANAGEMENT = "Management"
  ]

  attr_accessible :name, :version, :author, :agreement_execution
  has_many :agreement_executions

  validates :name, :presence => true
  validates :version, :presence => true, :numericality => {:only_integer => true}
  validates :author, :presence => true
  validates_inclusion_of :author, :in => ALL_AUTHOR_TYPES, :message => "Not the correct author type"
end
