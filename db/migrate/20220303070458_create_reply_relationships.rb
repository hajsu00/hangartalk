class CreateReplyRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :reply_relationships do |t|
      t.references :replying, null: false, foreign_key: { to_table: :microposts }
      t.references :replied, null: false, foreign_key: { to_table: :microposts }

      t.timestamps
    end
    add_index :reply_relationships, [:replying_id, :replied_id]
  end
end
