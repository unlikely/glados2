class Door < ActiveRecord::Base
  attr_accessible :name

  has_many :door_keys
  validates :name, :presence => true, :uniqueness => true

  def permitting_entry_to?(fob)
    if (door_keys.empty? || fob.user.nil?)
      return false
    elsif fob.user.door_keys.empty?
      return false
    else
      (fob.user.door_keys & door_keys).count > 0
    end
  end
end
