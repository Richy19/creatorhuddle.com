class ArticleDecorator < Draper::Decorator
  delegate_all

  decorates_association :comments
  decorates_association :user

  def content
    ContentRenderer.new(object.content).render
  end
end
