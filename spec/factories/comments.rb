FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :issue, factory: :issue
    content { FFaker::Lorem.paragraph(3) }
  end
end
