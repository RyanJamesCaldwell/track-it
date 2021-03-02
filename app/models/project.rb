class Project < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true,
            allow_blank: false,
            length: { minimum: 3, maximum: 50 }
end
