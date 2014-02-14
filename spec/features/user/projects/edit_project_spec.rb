require "spec_helper"

feature "Editing projects" do
  scenario "A user edits a project" do
    current_user = login create(:user)
    project = create :project, users: [current_user]

    visit root_path
    click_link 'projects'
    first(:link, project.name).click
    click_link 'edit project'

    fill_in 'project_name', with: 'new project name'
    click_button 'Update Project'

    page.should have_selector('h1', text: 'new project name')
    page.should have_text(project.summary)
  end
end
