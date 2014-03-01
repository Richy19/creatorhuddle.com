class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.boolean :positive
      t.integer :ratable_id
      t.string :ratable_type

      t.timestamps
    end
    add_index :ratings, :user_id
    add_index :ratings, :positive
    add_index :ratings, [:ratable_type, :ratable_id]
  end
end
