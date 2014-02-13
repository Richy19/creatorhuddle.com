require 'spec_helper'

describe Notification do
  it "has an unread scope" do
    unread_notification = create :notification
    create :notification, created_at: 31.days.ago
    create :notification, read: true

    Notification.unread.should eq([unread_notification])
  end

  it "has an unemailed scope" do
    unemailed_notification = create :notification
    create :notification, emailed: true

    Notification.unemailed.should eq([unemailed_notification])
  end

  it "has an emailable scope" do
    emailable_notification = create :notification
    create :notification, created_at: 31.days.ago
    create :notification, read: true
    create :notification, emailed: true

    Notification.emailable.should eq([emailable_notification])
  end
end
