# controller to handle requests to follow/unfollow projects
class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @follow = current_user.follows.where(follow_params).first_or_create!

    case @follow.followable_type
    when 'Project'
      redirect_to project_path(@follow.followable)
    else
      redirect_to root_path
    end
  end

  def destroy
    @follow = current_user.follows.where(id: params[:id]).first

    if @follow
      @follow.destroy

      case @follow.followable_type
      when 'Project'
        redirect_to project_path(@follow.followable)
      end
    else
      redirect_to root_path
    end
  end

  protected

  def follow_params
    params.require(:follow).permit(:followable_type, :followable_id)
  end
end
