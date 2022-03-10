class CreateShareRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :share_relationships do |t|
      t.references :sharing, null: false, foreign_key: { to_table: :microposts }
      t.references :shared, null: false, foreign_key: { to_table: :microposts }

      t.timestamps
    end
    add_index :share_relationships, [:sharing_id, :shared_id]
  end
end
