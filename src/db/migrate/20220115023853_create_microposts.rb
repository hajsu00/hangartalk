class CreateMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.boolean :is_flight_attached
      t.boolean :is_sharing_micropost
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
