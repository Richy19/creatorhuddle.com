class AddReadToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :read, :boolean, null: false, default: false
    add_index :notifications, :read
  end
end
