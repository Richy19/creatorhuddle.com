class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :followable_id
      t.string :followable_type
      t.integer :user_id

      t.timestamps
    end
    add_index :follows, :followable_id
    add_index :follows, :followable_type
    add_index :follows, :user_id
  end
end
