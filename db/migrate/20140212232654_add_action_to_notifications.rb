class AddActionToNotifications < ActiveRecord::Migration
  def change
    # nothing crucial is happening with these yet, so let's nuke them so we
    # don't have to worry about setting default values
    Notification.destroy_all
    add_column :notifications, :action, :string, null: false
  end
end
