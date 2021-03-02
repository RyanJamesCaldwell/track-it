class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :project_roles
  has_many :projects, through: :project_roles

  def is_admin_for?(project:)
    ProjectRole.find_by(user_id: id, project_id: project.id)&.role == 'admin'
  end
end
