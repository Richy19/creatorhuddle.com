require 'spec_helper'

feature "User sessions" do
  scenario "signing in to an account", :js do
    user = create(:user)

    visit root_path
    click_link 'log in'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    page.should have_text(/signed in/i)
  end

  scenario "signing out of an account" do
    user = login create(:user)

    visit root_path
    click_link 'log out'

    page.should have_text(/signed out/i)
  end
end
