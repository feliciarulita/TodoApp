FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    email { "#{name.parameterize}@gmail.com" }
    password { "123" }
    password_confirmation { "123" }
    manager { false }
  end

  factory :admin, class: "User" do
    name { Faker::Lorem.word }
    email { "#{name.parameterize}@gmail.com" }
    password { "123" }
    password_confirmation { "123" }
    manager { true }
  end
end
