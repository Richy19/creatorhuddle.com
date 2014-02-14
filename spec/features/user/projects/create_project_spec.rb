require "spec_helper"

feature "Creating projects" do
  scenario "A user creates a project" do
    login create(:user)

    visit root_path
    click_link 'projects'
    click_link 'add'

    fill_in 'project_name', with: 'Project name'
    fill_in 'project_homepage', with: 'http://www.creatorhuddle.com'
    fill_in 'project_summary', with: 'summar'
    fill_in 'wmd-input-details', with: 'Blah blah blah times a bajillion'
    click_button 'Create Project'

    page.should have_selector('h1', text: 'Project name')
    page.should have_text('summar')
    page.should have_text('Blah blah blah times a bajillion')
  end
end
