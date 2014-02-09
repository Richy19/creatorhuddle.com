class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects

  has_many :updates

  def can_manage?(object)
    case object
    when Project
      return can_manage_project?(object)
    when Update
      return can_manage_update?(object)
    end

    false
  end

  def can_manage_project?(project)
    UserProject.where(user_id: id, project_id: project.id).any?
  end

  def can_manage_update?(update)
    update.user_id == id
  end

  def name
    email
  end
end
