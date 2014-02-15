require 'redcarpet/render_strip'

class UpdateDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :comments

  def content
    ContentRenderer.new(object.content).render
  end

  def content_stripped
    ContentRenderer.new(object.content, strip: true).render
  end
end
