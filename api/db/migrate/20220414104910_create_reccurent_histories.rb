class CreateReccurentHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :reccurent_histories do |t|
      t.date :date
      t.integer :valid_for
      t.references :license, null: false, foreign_key: true

      t.timestamps
    end
  end
end
