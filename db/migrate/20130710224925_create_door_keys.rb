# can I use the t.belongs_to instead of making a foreign key for t.integer?
class CreateDoorKeys < ActiveRecord::Migration
  def change
    create_table :door_keys do |t|
      t.integer :user_id, null: false
      t.integer :door_id, null: false
      t.timestamps
    end
  end

  def down
  end
end
