class PossessionContract < ActiveRecord::Base
  ALL_CONTRACT_TYPES = [
    LEASE    = 'lease',
    BORROW   = 'borrow',
    DONATION = 'donation',
    SALE     = 'sale'
  ]

  attr_accessible :contract_type, :payment, :person, :equipment, :payment_cents, :expires, :person_id, :equipment_id
  belongs_to :person
  belongs_to :equipment

  validates :contract_type,      :presence => true
  validates :person,    :presence => true
  validates :equipment, :presence => true
  validates_inclusion_of :contract_type, :in => ALL_CONTRACT_TYPES, :message => "Value not accepted"
  validates_numericality_of :payment_cents, :only_integer => true, :allow_blank => true
  validates :payment_cents, :presence => true, :numericality => {:only_integer => true} , :if => :contract_type_is_lease?
  validates_presence_of :expires, :if => :contract_type_is_lease?

  def payment=(value)
    self.payment_cents = (value.to_f * 100).to_i
  end

  def payment
   if self.payment_cents.zero?
      self.payment_cents
    else
      self.payment_cents / 100
    end
  end

  private
  def contract_type_is_lease?
    contract_type == "lease"
  end

end
