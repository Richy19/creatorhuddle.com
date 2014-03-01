class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :user_id, null: false

      t.text :url, null: false
      t.text :name, null: false
      t.integer :score, null: false

      t.timestamps
    end
  end
end
