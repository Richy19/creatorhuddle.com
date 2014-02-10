# an update posted on a project or user page
class Update < ActiveRecord::Base
  belongs_to :updateable, polymorphic: true, touch: true
  belongs_to :user
  has_many :comments, as: :commentable

  validates :user, presence: true

  validate :user_can_manage_updateable

  def user_can_manage_updateable
    unless user && user.can_manage?(updateable)
      errors[:base] << "You can't manage updates for that!"
    end
  end

  def save_and_notify
    if new_record?
      case updateable
      when Project
        notify_project_followers
      end
    end

    save
  end

  def notify_project_followers
    updateable.followers.find_each do |follower|
      Notification.create!(target: self, receiver: follower, sender: user)
    end
  end
end
