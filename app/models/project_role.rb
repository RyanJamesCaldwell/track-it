class ProjectRole < ApplicationRecord
  enum role: [:standard, :admin]

  belongs_to :user
  belongs_to :project
end
