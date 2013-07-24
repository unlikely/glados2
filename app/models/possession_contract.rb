class PossessionContract < ActiveRecord::Base
  attr_accessible :type, :person, :equipment, :payment
  belongs_to :person
  belongs_to :equipment

  validates :type, :presence => true
end
