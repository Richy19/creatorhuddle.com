# This controller handles management of updates posted on project pages.
class UpdatesController < ApplicationController
  include Cruddy::Controller
  respond_to :html, :json

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_resource_instance, only: [:show, :edit, :update, :destroy]
  before_action :load_resource_collection, only: [:index]
  before_action :authorize_management!, only: [:edit, :update, :destroy]
  before_action :decorate_update, only: [:show, :edit]

  decorates_assigned :updates

  before_action :mark_collection_notifications_as_read, only: [:index]
  before_action :mark_individual_notifications_as_read, only: [:show]

  def mark_collection_notifications_as_read
    if user_signed_in?
      # this might be expensive when there are lots of updates
      # so let's make sure they have notifications
      if current_user.notifications.unread.any?
        @updates.find_each do |update|
          current_user.notifications.where(target_id: update.id).find_each do |notification|
            notification.read = true
            notification.save
          end
        end
      end
    end
  end

  def mark_individual_notifications_as_read
    if user_signed_in?
      # this might be expensive when there are lots of updates
      # so let's make sure they have notifications
      if current_user.notifications.unread.any?
        current_user.notifications.where(target_id: @update.id).find_each do |notification|
          notification.read = true
          notification.save
        end

        @update.comments.find_each do |comment|
          current_user.notifications.where(target_id: comment.id).find_each do |notification|
            notification.read = true
            notification.save
          end
        end
      end
    end
  end

  def index
  end

  # create action
  def create
    @update = initialize_resource_instance(resource_params)
    @update.user = current_user

    if resource.save_and_notify
      redirect_to polymorphic_path(@update.updateable)
    else
      respond_with(resource) do |format|
        format.html { render :new }
      end
    end
  end

  def destroy
    @update.destroy

    redirect_to polymorphic_path(@update.updateable)
  end

  def update
    if @update.update_attributes(resource_params)
      redirect_to polymorphic_path(@update.updateable)
    else
      respond_with(@update) do |format|
        format.html { render :edit }
      end
    end
  end

  protected

  def get_resource_collection
    @project = Project.where(id: params[:project_id]).first || not_found
    @updates = @project.updates
  end

  def initialize_resource_instance(params = nil)
    current_user.updates.build(params)
  end

  def decorate_update
    @decorated_update = @update.decorate
  end

  def resource_params
    params.require(:update).permit(:content, :updateable_id, :updateable_type)
  end

  def authorize_management!
    redirect_to root_path and return unless current_user.can_manage?(@update)
  end
end
