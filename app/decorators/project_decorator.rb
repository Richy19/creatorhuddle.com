# presentation logic for projects
class ProjectDecorator < Draper::Decorator
  delegate_all
  decorates_association :users
  decorates_association :updates

  def details
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    markdown.render(object.details).html_safe
  end
end
