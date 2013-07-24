class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :model, null: false
      t.string :make, null: false
      t.string :serial_number
      t.integer :replacement_cost
      t.timestamps
    end
  end

  def down
  end
end
