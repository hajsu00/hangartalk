class CreateLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :licenses do |t|
      t.string :code, null: false
      t.integer :license_category_id, null: false
      t.integer :aircraft_category_id, null: false
      t.date :date_of_issue, null: false
      t.references :user, null: false, foreign_key: true, index: false

      t.timestamps
    end
    add_index :licenses, [:user_id, :license_category_id, :aircraft_category_id], unique: true, name: 'index_for_user_license'
  end
end
