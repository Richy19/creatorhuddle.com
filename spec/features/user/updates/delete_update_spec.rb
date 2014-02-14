require 'spec_helper'

feature 'Delete updates' do
  scenario "A user deletes an update that they manage" do
    current_user = login create :user
    project = create :project, users: [current_user]
    update = create :update, updateable: project, user: current_user

    visit update_path(update)
    first('.delete-update').click

    page.should_not have_text(update.content)
  end

  scenario "A user deletes an update that they can't manage" do
    login create :user
    other_user = create :user
    project = create :project, users: [other_user]
    update = create :update, updateable: project, user: other_user

    visit update_path(update)

    page.should_not have_selector('.delete-update')
  end
end
