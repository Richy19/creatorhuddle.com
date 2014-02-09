require 'spec_helper'

describe User do
  describe '#can_manage?' do
    it 'allows a user to manage a project that they own' do
      user = create :user
      project = create :project, users: [user]

      user.can_manage?(project).should be_true
    end

    it "doesn't allow a user to manage a project that they don't own" do
      user = create :user
      project = create :project

      user.can_manage?(project).should be_false
    end

    it 'allows a user to manage an update that they own' do
      user = create :user
      project = create :project, users: [user]
      update = create :update, user: user, updateable: project

      user.can_manage?(update).should be_true
    end

    it "doesn't allow a user to manage an update that they don't own" do
      user = create :user
      other_user = create :user
      project = create :project, users: [other_user]
      update = create :update, user: other_user, updateable: project

      user.can_manage?(update).should be_false
    end
  end

  describe 'username validations' do
    it 'allows valid usernames' do
      build(:user, username: 'username').should be_valid
      build(:user, username: 'user.name').should be_valid
      build(:user, username: 'user_name').should be_valid
      build(:user, username: 'userName6').should be_valid
      build(:user, username: '9userName6').should be_valid
    end

    it "doesn't allow spaces in usernames" do
      build(:user, username: 'space name').should_not be_valid
    end

    it "doesn't allow @ in usernames" do
      build(:user, username: 'space@name').should_not be_valid
    end
  end
end
