class Door < ActiveRecord::Base
  has_many :door_keys
  validates :name, :presence => true, :uniqueness => true

  def entry_to?(fob)
    (fob.user.door_keys & door_keys).count > 0
  end
end
