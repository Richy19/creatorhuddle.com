# This controller handles management of updates posted on project pages.
class UpdatesController < ApplicationController
  include Cruddy::Controller
  respond_to :html, :json
  actions :new, :create, :edit, :update, :destroy

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_resource_instance, only: [:edit, :update, :destroy]
  before_action :authorize_management!, only: [:edit, :update, :destroy]

  def initialize_resource_instance(params = nil)
    current_user.updates.build(params)
  end

  # create action
  def create
    @update = initialize_resource_instance(resource_params)
    @update.user = current_user

    if resource.save_and_notify
      case @update.updateable_type
      when 'Project'
        redirect_to project_path(@update.updateable)
      end
    else
      respond_with(resource) do |format|
        format.html { render :new }
      end
    end
  end

  def destroy
    @update.destroy

    case @update.updateable_type
    when 'Project'
      redirect_to project_path(@update.updateable)
    end
  end

  def update
    if @update.update_attributes(resource_params)
      case @update.updateable_type
      when 'Project'
        redirect_to project_path(@update.updateable)
      end
    else
      respond_with(@update) do |format|
        format.html { render :edit }
      end
    end
  end

  protected

  def resource_params
    params.require(:update).permit(:content, :updateable_id, :updateable_type)
  end

  def authorize_management!
    redirect_to root_path and return unless current_user.can_manage?(@update)
  end
end
