class Issue < ApplicationRecord
  PRIORITIES = %w[critical major normal minor].freeze

  validates :title,
             presence: true,
             allow_blank: false,
             length: { minimum: 5,
                       maximum: 50 }
  validates :priority,
            inclusion: { in: PRIORITIES },
            allow_blank: true

  belongs_to :project
end
