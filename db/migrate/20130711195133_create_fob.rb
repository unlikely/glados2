class CreateFob < ActiveRecord::Migration
  def change
    create_table :fob do |t|
      t.string :key, null: false
      t.timestamps
    end
  end

  def down
  end
end
