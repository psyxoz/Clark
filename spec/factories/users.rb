FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@clark.de" }
    password { 'password' }
    password_confirmation { 'password' }

    trait(:admin) do
      role { User::ADMIN_ROLE }
    end
  end
end
