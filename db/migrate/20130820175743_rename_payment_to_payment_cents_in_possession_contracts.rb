class RenamePaymentToPaymentCentsInPossessionContracts < ActiveRecord::Migration
  def change
    rename_column :possession_contracts, :payment, :payment_cents
  end

end
