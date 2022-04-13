class CreateLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :licenses do |t|
      t.string :code
      t.integer :license_category
      t.integer :aircraft_category
      t.date :date_of_issue
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
