class AddUserIdToFobs < ActiveRecord::Migration
  def change
    add_column :fobs, :user_id, :integer
  end
end
