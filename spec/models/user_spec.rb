require 'spec_helper'

describe User do
  describe "#can_manage?" do
    it "allows a user to manage a project that they own" do
      user = create :user
      project = create :project, users: [user]

      user.can_manage?(project).should be_true
    end

    it "doesn't allow a user to manage a project that they don't own" do
      user = create :user
      project = create :project

      user.can_manage?(project).should be_false
    end
  end
end
