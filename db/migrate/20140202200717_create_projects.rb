class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
    add_index :projects, :name
    add_index :projects, :description
  end
end
