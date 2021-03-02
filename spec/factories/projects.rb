FactoryBot.define do
  factory :project do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.paragraph(4) }
  end
end
