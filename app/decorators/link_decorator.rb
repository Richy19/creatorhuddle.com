class LinkDecorator < Draper::Decorator
  delegate_all

  decorates_association :user
  decorates_association :comments

  def score
    object.ratings.positive.count - object.ratings.negative.count
  end

  def domain
    URI.parse(object.url).host
  end
end
