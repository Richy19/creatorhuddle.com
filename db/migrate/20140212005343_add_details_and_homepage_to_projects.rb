class AddDetailsAndHomepageToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :details, :text
    add_column :projects, :homepage, :text
  end
end
