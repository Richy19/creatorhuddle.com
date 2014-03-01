# Rating is a simple model that represents a user's upvote or
# downvote on another model on the site
class Rating < ActiveRecord::Base
  SCORE_LAUNCH_TIMESTAMP = 1393702506

  belongs_to :user
  belongs_to :ratable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:ratable_type, :ratable_id] }

  scope :positive, -> { where(positive: true) }
  scope :negative, -> { where(positive: false) }
end
