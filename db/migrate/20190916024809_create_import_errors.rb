class CreateImportErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :import_errors do |t|
      t.integer :row_number
      t.string :error_message
      t.references :csv_upload

      t.timestamps
    end
  end
end
