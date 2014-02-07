require "spec_helper"

feature "Deleting projects" do
  scenario "A user edits a project" do
    current_user = login create(:user)
    project = create :project, users: [current_user]

    visit root_path
    click_link 'projects'
    first(:link, project.name).click
    click_link 'delete project'

    page.should_not have_text(project.name)
  end
end
