FactoryBot.define do
  factory :issue, class: Issue do
    title { FFaker::Lorem.characters(20) }
    description { FFaker::Lorem.paragraph }
    category { %w[requirements design development bugfix testing documentation].sample }
    priority { %w[critical major normal minor].sample }
    state { ['open', 'in progress', 'ready for review', 'under review', 'reviewed - see comments', 'complete',
              'duplicate', 'obsolete', "won't fix"].sample }

    association :project, factory: :project
  end
end
