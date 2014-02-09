class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :updateable_id
      t.string :updateable_type
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :updates, :updateable_id
    add_index :updates, :updateable_type
  end
end
