# presentation logic for projects
class ProjectDecorator < Draper::Decorator
  delegate_all
  decorates_association :users
  decorates_association :followers
  decorates_association :updates

  def details
    ContentRenderer.new(object.details).render
  end
end
