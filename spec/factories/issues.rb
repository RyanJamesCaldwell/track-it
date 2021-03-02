FactoryBot.define do
  factory :issue do
    title { FFaker::Lorem.characters(20) }
    description { FFaker::Lorem.paragraph }
    category { 'normal' }
    priority { %i[critical major normal minor].sample }
    project { nil }
  end
end
