require "spec_helper"

feature "Following projects" do
  scenario "A user follows a project" do
    current_user = login create(:user)
    project = create :project

    visit project_path(project)
    click_button 'follow'

    page.should have_text('unfollow')
  end
end
