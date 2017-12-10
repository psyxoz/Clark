FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@clark.de" }
    password { SecureRandom.hex(10) }

    trait(:admin) do
      role { User::ADMIN_ROLE }
    end
  end
end
