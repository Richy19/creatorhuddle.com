# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :follow do
    followable { create :project }
    user { create :user }
  end
end
