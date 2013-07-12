class CreateFobs < ActiveRecord::Migration
  def change
    create_table :fobs do |t|
      t.string :key, null: false
      t.timestamps
    end

  end

  def down
  end
end
