require 'spec_helper'

describe Update do
  it 'makes sure that the user has permission to manage the updateable object' do
    user = create :user
    project = create :project
    update = build :update, updateable: project, user: user

    update.should_not be_valid
    update.errors[:base].should include("You can't manage updates for that!")
  end

  describe "notifications" do
    let(:sender) { create :user }
    let(:follower) { create :user }
    let(:project) { create :project, users: [sender] }
    let(:update) { build :update, updateable: project, user: sender }
    before { follower.follow(project) }

    it "creates a notification" do
      expect do
        update.save_and_notify
      end.to change(Notification, :count).by(1)
    end

    it "assigns the correct sender to the notification" do
      update.save_and_notify
      Notification.last.sender.should eq(sender)
    end

    it "assigns the correct receiver to the notification" do
      update.save_and_notify
      Notification.last.receiver.should eq(follower)
    end

    it "assigns the correct target to the notification" do
      update.save_and_notify
      update.reload
      Notification.last.target.should eq(update)
    end

    it "only sends notifications when the record is new" do
      update.save

      expect do
        update.save_and_notify
      end.not_to change(Notification, :count)
    end
  end
end
