FactoryBot.define do
  factory :task do
    name { Faker::Lorem.sentence(word_count: 3) }
    create_time { Time.current }
    end_time { 2.days.from_now }
    status { Task.statuses.keys.sample }
    priority { Task.priorities.keys.sample }
    tag { Faker::Lorem.word }
  end

  trait :later_create_time do
    create_time { 2.days.from_now }
    end_time { 4.days.from_now }
  end

  trait :earlier_end_time do
    end_time { 1.day.from_now }
  end

  trait :lower_priority do
    priority { :low }
  end

  trait :higher_priority do
    priority { :high }
  end
end
