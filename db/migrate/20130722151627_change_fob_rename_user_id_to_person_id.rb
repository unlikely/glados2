class ChangeFobRenameUserIdToPersonId < ActiveRecord::Migration
  def change
    change_table :fobs do |t|
      t.rename :user_id, :person_id
    end
  end

  def down
  end
end
