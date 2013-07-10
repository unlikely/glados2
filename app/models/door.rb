class Door < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
end
