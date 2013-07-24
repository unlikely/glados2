class AddPossessionContracts < ActiveRecord::Migration
  def change
    create_table :possession_contracts do |t|
      t.integer :person_id,     null: false
      t.integer :equipment_id,  null: false
      t.string  :type,          null: false
      t.integer :payment
      t.timestamps
    end
  end

  def down
  end
end
