# an update posted on a project or user page
class Update < ActiveRecord::Base
  belongs_to :updateable, polymorphic: true
  belongs_to :user

  validates :user, presence: true

  validate :user_can_manage_updateable

  def user_can_manage_updateable
    unless user && user.can_manage?(updateable)
      errors[:base] << "You can't manage updates for that!"
    end
  end
end
