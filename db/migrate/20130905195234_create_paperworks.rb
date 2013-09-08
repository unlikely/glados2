class CreatePaperworks < ActiveRecord::Migration
  def change
    create_table :paperworks do |t|
      t.string :name, null: false
      t.string :author, null: false
      t.integer :version, null: false
      t.timestamp
    end
  end

end
