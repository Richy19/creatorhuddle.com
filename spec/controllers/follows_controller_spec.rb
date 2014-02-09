require 'spec_helper'

describe FollowsController do
  context 'when a user is logged in' do
    let(:user) { create :user }
    before { sign_in user }

    context 'when targeting a project' do
      let(:project) { create :project }
      let(:follow_params) do
        {
          followable_id: project.id,
          followable_type: project.class.to_s
        }
      end

      describe 'POST create' do
        it 'assigns the follow to the current user' do
          post :create, follow: follow_params
          assigns(:follow).user.should eq(user)
        end

        it 'follows the project' do
          post :create, follow: follow_params
          user.followed_projects.should eq([project])
        end

        it 'creates a follow' do
          expect do
            post :create, follow: follow_params
          end.to change(Follow, :count).by(1)
        end

        it 'redirects to the followed project' do
          post :create, follow: follow_params
          response.should redirect_to(project_path(project))
        end

        context 'when the user already follows the project' do
          before { user.follow(project) }

          it "doesn't create another follow" do
            expect do
              post :create, follow: follow_params
            end.not_to change(Follow, :count)
          end
        end
      end

      describe 'DELETE destroy' do
        let!(:follow) { create :follow, followable_id: project.id, followable_type: project.class.to_s, user: user }

        it 'finds the follow' do
          delete :destroy, id: follow.id
          assigns(:follow).should eq(follow)
        end

        it "doesn't find other user's follows" do
          other_follow = create :follow
          delete :destroy, id: other_follow.id
          assigns(:follow).should_not eq(other_follow)
        end

        it 'deletes the follow' do
          expect do
            delete :destroy, id: follow.id
          end.to change(Follow, :count).by(-1)
        end

        it 'redirects to the unfollowed project' do
          delete :destroy, id: follow.id
          response.should redirect_to(project_path(project))
        end
      end
    end
  end
end
