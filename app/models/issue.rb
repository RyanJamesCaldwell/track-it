class Issue < ApplicationRecord
  PRIORITIES = %w[critical major normal minor].freeze
  CATEGORIES = %w[requirements design development bugfix testing documentation]

  validates :title,
             presence: true,
             allow_blank: false,
             length: { minimum: 5,
                       maximum: 50 }
  validates :priority,
            inclusion: { in: PRIORITIES },
            allow_blank: true

  validates :category,
            inclusion: { in: CATEGORIES },
            allow_blank: true

  belongs_to :project
end
