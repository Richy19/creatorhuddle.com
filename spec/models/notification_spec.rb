require 'spec_helper'

describe Notification do
  it "has an unread scope" do
    unread_notification = create :notification
    old_unread_notification = create :notification, created_at: 31.days.ago
    read_notification = create :notification, read: true

    Notification.unread.should eq([unread_notification])
  end
end
