class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  if Rails.env.production?
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  # this allows us to create devise forms in the application layout (for the modal log in/sign up windows)
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  helper_method :devise_mapping

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def render_error(status, exception)
    respond_to do |format|
      format.json { render nothing: true, status: status }
      format.all { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
    end
  end

  def require_admin
    redirect_to root_path and return unless user_signed_in? && current_user.admin?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :current_password)
    end
  end
end
