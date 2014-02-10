class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.integer :target_id
      t.string :target_type

      t.timestamps
    end
    add_index :notifications, :receiver_id
    add_index :notifications, :sender_id
    add_index :notifications, :target_id
    add_index :notifications, :target_type
  end
end
