class DropFob < ActiveRecord::Migration
  def up
    drop_table :fob
  end

  def down
  end
end
