# this handles all presentational logic relating to the comment model
class CommentDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def content
    if object.content.blank?
      ''
    else
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
      markdown.render(object.content).html_safe
    end
  end
end
