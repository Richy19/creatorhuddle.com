# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    url 'http://www.creatorhuddle.com'
    name 'Link'
    score 0

    before :create do |link|
      link.user = create :user if link.user.nil?
    end
  end
end
