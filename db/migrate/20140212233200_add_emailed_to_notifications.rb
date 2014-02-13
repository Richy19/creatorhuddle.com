class AddEmailedToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :emailed, :boolean, null: false, default: false
  end
end
