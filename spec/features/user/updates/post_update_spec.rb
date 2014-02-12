require 'spec_helper'

feature 'Posting updates' do
  scenario "A user posts an update to a project that they manage" do
    current_user = login create :user
    project = create :project, users: [current_user]

    visit project_path(project)

    fill_in 'update_content', with: 'this is my update'
    click_button 'post'

    page.should have_text 'this is my update'
  end

  scenario "A user posts an update to a project that they can't manage" do
    login create :user
    project = create :project

    visit project_path(project)

    page.should_not have_selector('#update_content')
    page.should_not have_button('Post')
  end
end
