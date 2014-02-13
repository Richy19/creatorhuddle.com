# notifications for users
class Notification < ActiveRecord::Base
  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User'
  belongs_to :target, polymorphic: true

  validates :action, presence: true

  scope :unread, -> { where(read: false).where(created_at: 30.days.ago..DateTime.now) }
  scope :unemailed, -> { where(emailed: false) }
  scope :emailable, -> { unread.unemailed }
end
