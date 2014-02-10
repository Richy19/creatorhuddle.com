class UsersController < ApplicationController
  include Cruddy::Controller
  actions :index, :show
  respond_to :html, :json
  decorates_assigned :user

  def get_resource_instance
    User.where(username: params[:username]).first
  end
end
