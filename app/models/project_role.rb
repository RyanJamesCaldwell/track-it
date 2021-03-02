class ProjectRole < ApplicationRecord
  enum role: [:standard, :admin]

  belongs_to :user
  belongs_to :project

  def self.find_by_user_and_project(user, project)
    ProjectRole.find_by(user_id: user.id, project_id: project.id)
  end
end
