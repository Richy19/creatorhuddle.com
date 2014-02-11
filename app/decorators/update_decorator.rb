class UpdateDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :comments
end
