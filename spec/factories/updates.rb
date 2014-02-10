# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :update do
    content 'Update content'

    user { FactoryGirl.create(:user) }
    updateable { |update| create :project, users: [update.user] }
  end
end
