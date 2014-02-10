class ProjectsController < ApplicationController
  include Cruddy::Controller
  respond_to :html, :json

  decorates_assigned :project

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_resource_instance, only: [:show, :edit, :update, :destroy]
  before_action :authorize_management!, only: [:edit, :update, :destroy]

  before_action :mark_notifications_as_read, only: [:show]

  def mark_notifications_as_read
    if user_signed_in?
      # this might be expensive when there are lots of updates
      # so let's make sure they have notifications
      if current_user.notifications.unread.any?
        @project.updates.find_each do |update|
          current_user.notifications.where(target_id: update.id).find_each do |notification|
            notification.read = true
            notification.save
          end
        end
      end
    end
  end

  def get_resource_collection
    if params[:show] == 'followed'
      authenticate_user!
      current_user.followed_projects.order(updated_at: :desc)
    else
      Project.order(updated_at: :desc)
    end
  end

  # redefining this to prevent loading the project twice
  def show
    respond_with @project
  end

  def initialize_resource_instance(params=nil)
    current_user.projects.build(params)
  end

  # create action
  def create
    @project = initialize_resource_instance(resource_params)
    @project.users << current_user

    if resource.save
      redirect_to resource_path(resource)
    else
      respond_with(resource) do |format|
        format.html { render :new }
      end
    end
  end

  protected

  def authorize_management!
    redirect_to projects_path and return unless current_user.can_manage?(@project)
  end
end
