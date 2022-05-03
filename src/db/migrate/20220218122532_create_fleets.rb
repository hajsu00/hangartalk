class CreateFleets < ActiveRecord::Migration[6.1]
  def change
    create_table :fleets do |t|
      t.string :ident
      t.integer :aircraft_type_id
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
