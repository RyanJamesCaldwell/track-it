class ProjectMembershipRequest < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user, uniqueness: { scope: :project }

  def self.find_by_user_and_project(user, project)
    return nil unless user && project
    ProjectMembershipRequest.find_by(user: user, project: project)
  end
end
