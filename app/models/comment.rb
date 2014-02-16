class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  acts_as_nested_set dependent: :destroy

  default_scope { order(created_at: :asc) }

  def save_and_notify
    if new_record?
      if parent
        # notify the person who posted the parent comment
      else
        notify_participants
      end
    end

    save
  end

  def notify_participants
    if commentable.respond_to?(:user)
      original_owners = [commentable.user]
    elsif commentable.respond_to?(:users)
      original_owners = commentable.users
    else
      original_owners = []
    end

    original_owners.each do |original_owner|
      Notification.create!(target: self, receiver: original_owner, sender: user, action: :posted) unless original_owner == user
    end

    commentable.comments.includes(:user).map(&:user).uniq.each do |commenter|
      if !original_owners.include?(commenter) && commenter != user
        Notification.create!(target: self, receiver: commenter, sender: user, action: :also_posted)
      end
    end
  end
end
