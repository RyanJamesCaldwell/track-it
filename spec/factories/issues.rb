FactoryBot.define do
  factory :issue, class: Issue do
    title { FFaker::Lorem.characters(20) }
    description { FFaker::Lorem.paragraph }
    category { %w[requirements design development bugfix testing documentation].sample }
    priority { %i[critical major normal minor].sample }

    association :project, factory: :project
  end
end
