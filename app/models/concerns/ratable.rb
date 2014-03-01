# Including this in a model allows it to be upvoted/downvoted
module Ratable
  extend ActiveSupport::Concern

  def calculate_score
    upvotes = ratings.positive.count
    downvotes = ratings.negative.count
    self.rating_score = (upvotes - downvotes)

    timestamp = new_record? ? DateTime.now.to_i : created_at.to_i
    time_adjustment = (timestamp - Rating::SCORE_LAUNCH_TIMESTAMP) / 1.day.to_i

    self.score = rating_score + time_adjustment
  end

  included do
    has_many :ratings, as: :ratable
  end
end
