FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "123" }
    password_confirmation { "123" }
    manager { false }
  end

  factory :admin, class: "User" do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email  }
    password { "123" }
    password_confirmation { "123" }
    manager { true }
  end
end
