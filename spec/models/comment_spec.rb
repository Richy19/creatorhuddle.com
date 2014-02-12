require 'spec_helper'

describe Comment do
  it "can be nested" do
    comment = create :comment
    comment2 = create :comment, parent: comment

    comment.children.should eq([comment2])
  end

  it "can be added to an update" do
    update = create :update
    comment = create :comment, commentable: update

    update.comments.should eq([comment])
  end

  describe "notifications" do
    let(:sender) { create :user }
    let(:project_owner) { create :user }
    let(:project) { create :project, users: [project_owner] }
    let(:update) { create :update, updateable: project, user: project_owner }
    let(:comment) { build :comment, commentable: update, user: sender }

    it "notifies the update owner" do
      expect do
        comment.save_and_notify
      end.to change(Notification, :count).by(1)

      Notification.where(sender: sender, receiver: project_owner, target: comment).should_not be_empty
    end

    it "notifies other commenters" do
      other_commenter = create :user
      other_comment = create :comment, commentable: update, user: other_commenter

      comment.save_and_notify

      Notification.where(sender: sender, receiver: other_commenter, target: comment).should_not be_empty
    end

    it "only sends notifications when the record is new" do
      update.save

      expect do
        update.save_and_notify
      end.not_to change(Notification, :count)
    end
  end
end
