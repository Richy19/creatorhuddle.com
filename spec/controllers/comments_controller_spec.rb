require 'spec_helper'

describe CommentsController do
  describe 'POST create' do
    context 'when a user is logged in' do
      let(:current_user) { create :user }
      before { sign_in current_user }

      context 'when applied to a project update' do
        let(:project) { create :project, users: [current_user] }
        let(:update) { create :update, updateable: project, user: current_user }
        let(:comment_params) do
          attributes_for :comment,
                         commentable_type: update.class.to_s,
                         commentable_id: update.id,
                         user: current_user
        end

        it 'initializes a comment for the current user' do
          post :create, comment: comment_params
          assigns(:comment).user.should eq(current_user)
        end

        it "redirects to the update's project" do
          post :create, comment: comment_params
          response.should redirect_to update_path(update)
        end

        it 'creates a comment' do
          expect do
            post :create, comment: comment_params
          end.to change(Comment, :count).by(1)
        end

        it 'creates notifications' do
          Comment.any_instance.should_receive(:save_and_notify)
          post :create, comment: comment_params
        end
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when a user is logged in' do
      let(:current_user) { create :user }
      before { sign_in current_user }

      let(:project) { create :project, users: [current_user] }
      let(:update) { create :update, updateable: project, user: current_user }
      let!(:comment) do
        create :comment, commentable_id: update.id, commentable_type: update.class.to_s, user_id: current_user.id
      end

      context 'when the user can manage the project' do
        it 'deletes the comment' do
          expect do
            delete :destroy, id: comment.id
          end.to change(Comment, :count).by(-1)
        end
      end

      context "when the user can't manage the comment" do
        before do
          comment.update_attribute(:user_id, 0)
        end

        it "doesn't comment the comment" do
          expect do
            delete :destroy, id: comment.id
          end.not_to change(Comment, :count)
        end
      end
    end
  end
end
