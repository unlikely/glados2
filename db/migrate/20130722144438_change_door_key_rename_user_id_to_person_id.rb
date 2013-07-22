class ChangeDoorKeyRenameUserIdToPersonId < ActiveRecord::Migration
  def change
    change_table :door_keys do |t|
      t.rename :user_id, :person_id
    end
  end

  def down
  end
end
