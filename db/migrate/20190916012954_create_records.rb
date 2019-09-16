class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.string :first
      t.string :last
      t.string :phone
      t.string :email
      t.references :csv_upload

      t.timestamps
    end
  end
end
