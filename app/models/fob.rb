class Fob < ActiveRecord::Base
  attr_accessible :key, :user
  belongs_to :user
  validates :key, :presence => true, :uniqueness => true
end
