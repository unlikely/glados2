class Door < ActiveRecord::Base
  attr_accessible :name

  has_many :door_keys
  validates :name, :presence => true, :uniqueness => true

  def permitting_entry_to?(fob)
    if (door_keys.empty? || fob.person.nil?)
      return false
    elsif fob.person.door_keys.empty?
      return false
    else
      (fob.person.door_keys & door_keys).count > 0
    end
  end
end
