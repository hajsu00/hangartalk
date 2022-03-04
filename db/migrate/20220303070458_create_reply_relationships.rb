class CreateReplyRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :reply_relationships do |t|
      t.integer :replying_id
      t.integer :replied_id

      t.timestamps
      end
      add_index :reply_relationships, :replying_id
      add_index :reply_relationships, :replied_id
      add_index :reply_relationships, [:replying_id, :replied_id]
  end
end
