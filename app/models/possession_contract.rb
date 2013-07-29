class PossessionContract < ActiveRecord::Base
  attr_accessible :type, :person, :equipment, :payment, :expires
  belongs_to :person
  belongs_to :equipment

  validates :type,      :presence => true
  validates :person,    :presence => true
  validates :equipment, :presence => true
  validates_inclusion_of :type, :in => %w(lease borrow donation sale), :message => "Value not accepted"

end
