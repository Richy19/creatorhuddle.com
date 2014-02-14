# This controller handles management of comments
class CommentsController < ApplicationController
  include Cruddy::Controller
  respond_to :html, :json
  actions :new, :create, :edit, :update, :destroy

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_resource_instance, only: [:edit, :update, :destroy]
  before_action :authorize_management!, only: [:edit, :update, :destroy]

  def initialize_resource_instance(params = nil)
    current_user.comments.build(params)
  end

  # create action
  def create
    @comment = initialize_resource_instance(resource_params)
    @comment.user = current_user

    if resource.save_and_notify
      redirect_to polymorphic_path(@comment.commentable)
    else
      respond_with(resource) do |format|
        format.html { render :new }
      end
    end
  end

  def destroy
    @comment.destroy

    redirect_to polymorphic_path(@comment.commentable)
  end

  def update
    if @comment.comment_attributes(resource_params)
      redirect_to polymorphic_path(@comment.commentable)
    else
      respond_with(@comment) do |format|
        format.html { render :edit }
      end
    end
  end

  protected

  def resource_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end

  def authorize_management!
    redirect_to root_path and return unless current_user.can_manage?(@comment)
  end
end
