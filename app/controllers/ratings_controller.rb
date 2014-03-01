# Allows users to upvote/downvote things
class RatingsController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!

  def create
    @rating = current_user.ratings.where(
      ratable_id: params[:rating][:ratable_id],
      ratable_type: params[:rating][:ratable_type]
    ).first_or_initialize

    @rating.positive = true # params[:rating][:positive]
    @rating.save!

    @rating.ratable.calculate_score
    @rating.ratable.save!

    respond_with @rating.ratable
  end
end
