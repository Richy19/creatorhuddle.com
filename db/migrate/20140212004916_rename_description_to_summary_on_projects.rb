class RenameDescriptionToSummaryOnProjects < ActiveRecord::Migration
  def change
    rename_column :projects, :description, :summary
  end
end
