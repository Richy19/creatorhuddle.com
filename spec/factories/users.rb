# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "email_#{n}@test.com" }
    password 'password'
    password_confirmation 'password'
  end
end
