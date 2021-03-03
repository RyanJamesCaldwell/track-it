class Project < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true,
            allow_blank: false,
            length: { minimum: 3, maximum: 30 }

  has_many :issues, dependent: :destroy
  has_many :project_roles, dependent: :destroy
  has_many :project_membership_requests, dependent: :destroy
end
