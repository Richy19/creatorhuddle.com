require 'digest/md5'

# presentation related code for users
class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def name
    h.link_to object.name, h.user_url(object)
  end

  def gravatar_url
    email_address = object.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    "http://www.gravatar.com/avatar/#{hash}"
  end
end
