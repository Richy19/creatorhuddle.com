class ArticlesController < ApplicationController
  include Cruddy::Controller
  respond_to :html, :json

  decorates_assigned :article, :articles

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_resource_instance, only: [:show, :edit, :update, :destroy]
  before_action :authorize_management!, only: [:edit, :update, :destroy]

  before_action :mark_notifications_as_read, only: [:show]

  def get_resource_collection
    Article.order(created_at: :desc)
  end

  def mark_notifications_as_read
    if user_signed_in?
      # this might be expensive when there are lots of updates
      # so let's make sure they have notifications
      if current_user.notifications.unread.any?
        @article.comments.find_each do |comment|
          current_user.notifications.where(target_id: comment.id).find_each do |notification|
            notification.read = true
            notification.save
          end
        end
      end
    end
  end

  # redefining this to prevent loading the article twice
  def show
    respond_with @article
  end

  def initialize_resource_instance(params=nil)
    current_user.articles.build(params)
  end

  # create action
  def create
    @article = initialize_resource_instance(resource_params)
    @article.user = current_user

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
    redirect_to articles_path and return unless current_user.can_manage?(@article)
  end
end
