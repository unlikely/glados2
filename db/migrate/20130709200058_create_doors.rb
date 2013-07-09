class CreateDoors < ActiveRecord::Migration
  def change
    create_table :doors do |t|
      t.string :name, null: false
      t.timestamps
    end
  end

  def down
  end
end
