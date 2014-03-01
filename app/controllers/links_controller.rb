# Controller for reddit/HN style link sharing
class LinksController < ApplicationController
  include Cruddy::Controller
  respond_to :html, :json

  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_management!, only: [:edit, :update, :destroy]

  before_action :mark_individual_notifications_as_read, only: [:show]

  decorates_assigned :link, :links

  def initialize_resource_instance(params = nil)
    link = current_user.links.build(params)
    link.calculate_score
    link
  end

  def index
    @new_link = user_signed_in? ? initialize_resource_instance : Link.new
  end

  def get_resource_collection
    links = case params[:show]
    when 'top'
      Link.order(rating_score: :desc)
    when 'new'
      Link.order(created_at: :desc)
    when 'yours'
      authenticate_user!
      current_user.links.order(created_at: :desc)
    else
      Link.order(score: :desc)
    end

    links.paginate(per_page: 50, page: params[:page])
  end

  private

  def authorize_management!
    redirect_to links_path and return unless current_user.can_manage?(@link)
  end

  def mark_individual_notifications_as_read
    if user_signed_in?
      # this might be expensive when there are lots of updates
      # so let's make sure they have notifications
      if current_user.notifications.unread.any?
        current_user.notifications.where(target_id: @link.id, target_type: @link.class.to_s).find_each do |notification|
          notification.read = true
          notification.save
        end

        @link.comments.find_each do |comment|
          current_user.notifications.where(target_id: comment.id, target_type: comment.class.to_s).find_each do |notification|
            notification.read = true
            notification.save
          end
        end
      end
    end
  end
end
