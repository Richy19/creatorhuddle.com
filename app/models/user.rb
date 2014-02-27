class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects

  has_many :comments
  has_many :articles
  has_many :updates
  has_many :follows

  has_many :followed_projects, through: :follows, source: :followable, source_type: 'Project'

  has_many :notifications, foreign_key: :receiver_id

  validates :username, presence: true, uniqueness: true, length: 2..32
  validates_format_of :username, with: /\A[-a-z0-9_]+\Z/i, message: 'may only contain letters, numbers, "-" and "_"'

  def can_manage?(object)
    case object
    when Project
      return can_manage_project?(object)
    else
      return object.user_id == id
    end

    false
  end

  def to_param
    username
  end

  def follow(object)
    follows.create!(followable: object)
  end

  def follows?(object)
    !!follow_for(object)
  end

  def follow_for(object)
    follows.where(followable_type: object.class.to_s, followable_id: object.id).first
  end

  def can_manage_project?(project)
    UserProject.where(user_id: id, project_id: project.id).any?
  end

  def name
    "@#{username}"
  end
end
