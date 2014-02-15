# this handles all presentational logic relating to the comment model
class CommentDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def content
    ContentRenderer.new(object.content).render
  end
end
