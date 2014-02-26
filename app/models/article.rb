class Article < ActiveRecord::Base
  include Commentable

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  belongs_to :user
end
