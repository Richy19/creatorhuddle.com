class Project < ActiveRecord::Base
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :updates, as: :updateable
  has_many :follows, as: :followable
  has_many :followers, through: :follows, source: :user
end
