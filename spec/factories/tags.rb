FactoryBot.define do
  factory :tag_urgent, class: 'Tag' do
    name { "Urgent" }
  end

  factory :tag_work, class: 'Tag' do
    name { "Work" }
  end

  factory :tag_school, class: 'Tag' do
    name { "School" }
  end

  factory :tag_personal, class: 'Tag' do
    name { "Personal" }
  end
end
