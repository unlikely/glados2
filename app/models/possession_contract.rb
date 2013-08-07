class PossessionContract < ActiveRecord::Base
  attr_accessible :contract_type, :person, :equipment, :payment, :expires
  belongs_to :person
  belongs_to :equipment

  validates_numericality_of :payment, :only_integer => true, :allow_blank => true
  validates :contract_type,      :presence => true
  validates :person,    :presence => true
  validates :equipment, :presence => true
  validates_inclusion_of :contract_type, :in => %w(lease borrow donation sale), :message => "Value not accepted"
end
