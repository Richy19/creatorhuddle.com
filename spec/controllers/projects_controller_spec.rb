require 'spec_helper'

describe ProjectsController do
  describe "GET show" do
    context "when logged in" do
      let(:current_user) { create :user }
      before { sign_in current_user }

      let(:project_owner) { create :user }
      let(:project) { create :project, users: [project_owner] }
      let(:update) { create :update, user: project_owner, updateable: project }

      context 'when the current user has an unread update notification' do
        let!(:notification) { create :notification, target: update, sender: project_owner, receiver: current_user }

        it "marks the notification as read" do
          get :show, id: project.id
          current_user.notifications.unread.should be_empty
          notification.reload.read.should be_true
        end
      end
    end
  end

  describe "POST create" do
    context "when logged in" do
      let(:current_user) { create(:user) }
      let(:project_params) { attributes_for(:project) }
      before { sign_in current_user }

      it "should assign the project to the current user by default" do
        post :create, project: project_params
        assigns(:project).users.should eq([current_user])
      end
    end
  end

  describe "GET edit" do
    context "when logged in" do
      let(:current_user) { create(:user) }
      before { sign_in current_user }

      context "when the current user can't manage the project" do
        let(:project) { create(:project) }

        it "redirects to the project index" do
          get :edit, id: project.id
          response.should redirect_to(projects_path)
        end
      end

      context "when the current user can manage the project" do
        let(:project) { create(:project, users: [current_user]) }

        it "renders the edit page" do
          get :edit, id: project.id
          response.should render_template(:edit)
        end
      end
    end
  end

  describe "PATCH update" do
      context "when logged in" do
        let(:current_user) { create(:user) }
        let(:project_params) { attributes_for(:project) }
        before { sign_in current_user }

        context "when the current user can't manage the project" do
          let(:project) { create(:project) }

          it "redirects to the project index" do
            patch :update, id: project.id, project: project_params
            response.should redirect_to(projects_path)
          end
        end

        context "when the current user can manage the project" do
          let(:project) { create(:project, users: [current_user]) }

          it "redirects to the project" do
            patch :update, id: project.id, project: project_params
            response.should redirect_to(project_path(project))
          end
        end
      end
    end

    describe "DELETE destroy" do
      context "when logged in" do
        let(:current_user) { create(:user) }
        before { sign_in current_user }

        context "when the current user can't manage the project" do
          let(:project) { create(:project) }

          it "doesn't destroy the project" do
            # make sure this doesn't get lazy eval'd in the block below causing
            # the count to change at the wrong time
            project

            expect {
              delete :destroy, id: project.id
            }.not_to change(Project, :count)
          end
        end

        context "when the current user can manage the project" do
          let(:project) { create(:project, users: [current_user]) }

          it "destroys the project" do
            # make sure this doesn't get lazy eval'd in the block below causing
            # the count to change at the wrong time
            project

            expect {
              delete :destroy, id: project.id
            }.to change(Project, :count).by(-1)
          end
        end
      end
    end
end
