class Equipment < ActiveRecord::Base
  attr_accessible :model, :make, :serial_number, :replacement_cost

  validates :model, :presence => { :message => "Please enter a model name"}
  validates :make, :presence => { :message => "Please enter make"}
  validates_numericality_of :replacement_cost, :only_integer => true, :allow_blank => true

  def self.search(search)
  	if search
  		find(:all, :conditions => [ 'make || model LIKE ?', "%#{search}%"])
  	else
  		find(:all)
  	end
  end
end
