class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  acts_as_nested_set dependent: :destroy

  def save_and_notify
    if new_record?
      if parent
        # notify the person who posted the parent comment
      else
        case commentable
        when Update
          notify_update_participants
        end
      end
    end

    save
  end

  def notify_update_participants
    update_owner = commentable.user

    Notification.create!(target: self, receiver: update_owner, sender: user, action: :posted) if update_owner != user

    commentable.comments.includes(:user).map(&:user).uniq.each do |commenter|
      if commenter != update_owner && commenter != user
        Notification.create!(target: self, receiver: commenter, sender: user, action: :also_posted)
      end
    end
  end
end
