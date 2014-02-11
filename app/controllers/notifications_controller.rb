class NotificationsController < ApplicationController
  include Cruddy::Controller
  actions :index
  respond_to :html, :json

  before_action :authenticate_user!

  def get_resource_collection
    current_user.notifications.order(created_at: :desc)
  end
end
