FactoryBot.define do
  factory :task do
    name { Faker::Lorem.sentence(word_count: 3) }
    create_time { Time.current }
    end_time { 2.days.from_now }
    status { Task.statuses.keys.sample }
    priority { Task.priorities.keys.sample }
    tag { Faker::Lorem.word }
  end
end
