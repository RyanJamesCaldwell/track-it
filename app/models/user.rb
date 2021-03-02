class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :project_roles, dependent: :destroy
  has_many :projects, through: :project_roles

  def is_admin_for?(project:)
    return false if project.nil?
    ProjectRole.find_by(user_id: id, project_id: project.id)&.role == 'admin'
  end

  def is_member_of?(project:)
    return false if project.nil?
    ProjectRole.find_by_user_and_project(self, project)
  end
end
