class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :project_roles, dependent: :destroy
  has_many :projects, through: :project_roles
  has_many :membership_requests, dependent: :destroy

  def is_admin_for?(project:)
    return false if project.nil?
    ProjectRole.find_by(user_id: id, project_id: project.id)&.role == 'admin'
  end

  def is_member_of?(project:)
    return false if project.nil?
    ProjectRole.find_by_user_and_project(self, project)
  end

  def can_request_membership_for?(project: project)
    !has_open_request_to_project?(project) && !is_member_of?(project: project)
  end

  private

  def has_open_request_to_project?(project)
    MembershipRequest.find_by(user: self,
                              project: project,
                              accepted_at: nil,
                              rejected_at: nil)
  end
end
