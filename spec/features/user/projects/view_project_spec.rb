require "spec_helper"

feature "Viewing a project" do
  scenario "A user view a project" do
    project = create :project

    visit root_path
    click_link 'projects'
    click_link project.name

    page.should have_selector('h1', text: /#{project.name}/i)
    page.should have_text(project.description)

    # user shouldn't see management buttons
    page.should_not have_text('edit project')
    page.should_not have_text('delete project')
  end

  scenario "A user views their own project" do
    user = login create(:user)
    project = create :project, users: [user]

    visit root_path
    click_link 'projects'
    first(:link, project.name).click

    page.should have_selector('h1', text: /#{project.name}/i)
    page.should have_text(project.description)

    # user should see management buttons
    page.should have_text('edit project')
    page.should have_text('delete project')
  end
end
