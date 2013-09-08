class RenameColumnPaperworkIdToAgreementIdInAgreementExecution < ActiveRecord::Migration
  def change
    rename_column :agreement_executions, :paperwork_id, :agreement_id
  end

end
