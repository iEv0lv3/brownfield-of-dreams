FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Creature::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    github_url { nil }
    # token { Faker::Crypto.md5 }
    role { :default }
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
