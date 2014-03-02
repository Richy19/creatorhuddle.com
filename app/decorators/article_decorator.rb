class ArticleDecorator < Draper::Decorator
  delegate_all

  decorates_association :comments
  decorates_association :user

  def content
    ContentRenderer.new(object.content).render
  end

  def content_stripped
    ContentRenderer.new(object.content, strip: true).render
  end
end
