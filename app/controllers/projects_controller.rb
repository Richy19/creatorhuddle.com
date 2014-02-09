class ProjectsController < ApplicationController
  include Cruddy::Controller
  respond_to :html, :json

  decorates_assigned :project

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_resource_instance, only: [:edit, :update, :destroy]
  before_action :authorize_management!, only: [:edit, :update, :destroy]

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
