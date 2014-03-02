# presentation logic for projects
class ProjectDecorator < Draper::Decorator
  delegate_all
  decorates_association :users
  decorates_association :followers
  decorates_association :updates
  decorates_association :comments

  def details
    ContentRenderer.new(object.details).render
  end

  def details_stripped
    ContentRenderer.new(object.details, strip: true).render
  end
end
