# presentation logic for projects
class ProjectDecorator < Draper::Decorator
  delegate_all
  decorates_association :users
  decorates_association :updates
end
