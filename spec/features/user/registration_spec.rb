require 'spec_helper'

feature "User registration" do
  scenario "creating an account through the registration form", :js do
    visit root_path
    click_link 'sign up'

    fill_in 'Email', with: 'user@test.com'
    find('#user_password').set('password')
    find('#user_password_confirmation').set('password')
    click_button 'Sign up'

    page.should have_text(/welcome/i)
  end
end
