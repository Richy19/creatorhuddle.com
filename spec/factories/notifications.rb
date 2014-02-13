# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    receiver_id 1
    sender_id 1
    target_id 1
    action 'factory'
    target_type "MyString"
  end
end
