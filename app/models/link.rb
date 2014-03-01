# Links are used for reddit/HN inspired pages
class Link < ActiveRecord::Base
  include Commentable
  include Ratable

  belongs_to :user

  before_validation :smart_add_url_protocol

  validate :validate_url
  validates :url, presence: true
  validates :name, presence: true, length: 3..255

  protected

  def validate_url
    !!URI.parse(url)
  rescue URI::InvalidURIError
    errors[:url] << "That's not a valid link"
  end

  def smart_add_url_protocol
    unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      self.url = "http://#{url}"
    end
  end
end
