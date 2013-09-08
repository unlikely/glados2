class CreateAgreementExecutions < ActiveRecord::Migration
  def change
    create_table :agreement_executions do |t|
      t.integer :person_id,     null: false
      t.integer :paperwork_id,  null: false
      t.date    :date_signed,   null: false
      t.string  :agreement_url, null: false
      t.timestamps
    end
  end
end
