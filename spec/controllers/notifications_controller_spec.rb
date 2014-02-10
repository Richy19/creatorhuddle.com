require 'spec_helper'

describe NotificationsController do
  describe 'GET index' do
    let(:receiver) { create :user }
    let(:sender) { create :user }
    let(:project) { create :project, users: [sender] }
    let(:target) { create :update, user: sender, updateable: project }
    let(:notification) { create :notification, target: target, receiver: receiver }
    let(:notification_2) { create :notification, target: target, receiver: sender }
    before { sign_in receiver }

    it "only loads the receiver's notifications" do
      # fix lazy-loading
      notification
      notification_2

      get :index
      assigns(:notifications).should eq([notification])
    end
  end
end
