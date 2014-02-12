require "spec_helper"

feature "Creating projects" do
  scenario "A user creates a project" do
    login create(:user)

    visit root_path
    click_link 'projects'
    click_link 'add'

    fill_in 'Name', with: 'Project name'
    fill_in 'Homepage', with: 'http://www.creatorhuddle.com'
    fill_in 'Summary', with: 'summar'
    fill_in 'Details', with: 'Blah blah blah times a bajillion'
    click_button 'Create Project'

    page.should have_selector('h1', text: 'Project name')
    page.should have_text('summar')
    page.should have_text('Blah blah blah times a bajillion')
  end
end
