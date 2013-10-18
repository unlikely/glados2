class AddStartDateToPossessionContracts < ActiveRecord::Migration
  def change
    add_column :possession_contracts, :start_date, :date
  end
end
