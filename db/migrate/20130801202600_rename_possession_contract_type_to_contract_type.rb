class RenamePossessionContractTypeToContractType < ActiveRecord::Migration
  def change
    rename_column :possession_contracts, :type, :contract_type
  end
end
