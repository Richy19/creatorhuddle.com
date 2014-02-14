class UpdateDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :comments

  def content
    if object.content.blank?
      ''
    else
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
      markdown.render(object.content).html_safe
    end
  end

  def content_stripped
    if object.content.blank?
      ''
    else
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::StripDown, space_after_headers: true)
      markdown.render(object.content).html_safe
    end
  end
end
