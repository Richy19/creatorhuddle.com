class NotificationEmailsWorker
  include Sidekiq::Worker

  def perform
    User.find_each do |user|
      NotificationMailer.notifications(user.id).deliver if user.notifications.emailable.any?
    end
  end
end
