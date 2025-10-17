FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    email { "#{name.parameterize}@gmail.com" }
    password_digest { "123" }
    manager { false }
  end
end
