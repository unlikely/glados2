class PossessionContract < ActiveRecord::Base
  ALL_CONTRACT_TYPES = [
    LEASE    = 'lease',
    BORROW   = 'borrow',
    DONATION = 'donation',
    SALE     = 'sale'
  ]

  attr_accessible :contract_type, :person, :equipment, :payment, :expires, :person_id, :equipment_id
  belongs_to :person
  belongs_to :equipment

  validates :contract_type,      :presence => true
  validates :person,    :presence => true
  validates :equipment, :presence => true
  validates_inclusion_of :contract_type, :in => ALL_CONTRACT_TYPES, :message => "Value not accepted"
  validates_numericality_of :payment, :only_integer => true, :allow_blank => true
  validates_presence_of :payment, :if => :contract_type_is_lease?
  validates_presence_of :expires, :if => :contract_type_is_lease?

  private
  def contract_type_is_lease?
    contract_type == "lease"
  end

end
