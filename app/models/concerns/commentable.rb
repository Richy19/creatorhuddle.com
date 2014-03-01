# this allows a model to be commented on
module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
  end
end
