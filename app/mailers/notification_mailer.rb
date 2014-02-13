# mail users about notifications they receive on the website
class NotificationMailer < ActionMailer::Base
  layout 'email'
  default from: "\"creatorhuddle\" <hello@creatorhuddle.com>"
  include SendGrid

  def notifications(user_id)
    @user = User.find(user_id)
    @notifications = @user.notifications.emailable.decorate
    @send_to = @user.email

    if @notifications.any?
      @notifications.each do |notification|
        notification.emailed = true
        notification.save
      end

      mail to: @send_to, subject: "You've got new notifications on creatorhuddle. Hooray!"
    end
  end
end
