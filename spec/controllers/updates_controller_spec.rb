require 'spec_helper'

describe UpdatesController do
  describe 'POST create' do
    context 'when a user is logged in' do
      let(:current_user) { create :user }
      before { sign_in current_user }

      context 'when applied to a project' do
        let(:project) { create :project }
        let(:update_params) do
          attributes_for :update,
                         updateable_type: project.class.to_s,
                         updateable_id: project.id,
                         user: current_user
        end

        context 'when the user can manage the project' do
          before { project.users << current_user }

          it 'initializes an update for the current user' do
            post :create, update: update_params
            assigns(:update).user.should eq(current_user)
          end

          it "redirects to the update's project" do
            post :create, update: update_params
            response.should redirect_to project_path(project)
          end

          it 'creates an update' do
            expect do
              post :create, update: update_params
            end.to change(Update, :count).by(1)
          end

          it 'creates notifications' do
            Update.any_instance.should_receive(:save_and_notify)
            post :create, update: update_params
          end
        end

        context "when the user can't manage the project" do
          it "doesn't create an update" do
            expect do
              post :create, update: update_params
            end.not_to change(Update, :count)
          end
        end
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when a user is logged in' do
      let(:current_user) { create :user }
      before { sign_in current_user }

      context 'when applied to a project' do
        let(:project) { create :project, users: [current_user] }
        let!(:update) do
          create :update, updateable_id: project.id, updateable_type: project.class.to_s, user_id: current_user.id
        end

        context 'when the user can manage the project' do
          it 'deletes the update' do
            expect do
              delete :destroy, id: update.id
            end.to change(Update, :count).by(-1)
          end
        end

        context "when the user can't manage the update" do
          before do
            update.update_attribute(:user_id, 0)
          end

          it "doesn't update the update" do
            expect do
              delete :destroy, id: update.id
            end.not_to change(Update, :count)
          end
        end
      end
    end
  end
end
