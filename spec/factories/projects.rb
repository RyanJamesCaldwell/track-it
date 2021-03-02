FactoryBot.define do
  factory :project do
    name { FFaker::Lorem.characters(15) }
    description { FFaker::Lorem.paragraph(4) }
  end
end
