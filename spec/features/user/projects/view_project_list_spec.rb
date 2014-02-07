require "spec_helper"

feature "Viewing the project list" do
  scenario "A user views the project list" do
    project = create :project

    visit root_path
    click_link 'projects'

    page.should have_selector('h1', text: /projects/i)
    page.should have_text(project.name)
  end
end
