require "spec_helper"

feature "Creating projects" do
  scenario "A user creates a project" do
    login create(:user)

    visit root_path
    click_link 'projects'
    click_link 'add a project'

    fill_in 'Name', with: 'Project name'
    fill_in 'Description', with: 'Blah blah blah'
    click_button 'Create Project'

    page.should have_selector('h1', text: 'Project name')
    page.should have_text('Blah blah blah')
  end
end
