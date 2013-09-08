class RenameTablePaperworksToAgreements < ActiveRecord::Migration
  def change
    rename_table :paperworks, :agreements
  end
end
