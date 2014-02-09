require "spec_helper"

feature "unfollowing projects" do
  scenario "A user unfollows a project" do
    current_user = login create(:user)
    project = create :project

    current_user.follow(project)

    visit project_path(project)
    click_link 'unfollow'

    page.should have_selector('.btn-follow')
  end
end
