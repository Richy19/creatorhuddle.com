# presentation logic for notifications
class NotificationDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def display
    locals = { notification: self }
    locals[object.target_type.underscore.to_sym] = object.target
    h.render partial_path, locals
  end

  def partial_path
    "notifications/#{object.target_type.underscore}/#{object.action}"
  end
end
