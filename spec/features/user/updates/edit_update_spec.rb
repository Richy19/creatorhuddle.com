require 'spec_helper'

feature 'Editing updates' do
  scenario "A user edits an updatethat they manage" do
    current_user = login create :user
    project = create :project, users: [current_user]
    create :update, updateable: project, user: current_user

    visit project_path(project)
    first('.edit-update').click

    fill_in 'Content', with: 'new update content'
    click_button 'Save'

    page.should have_text('new update content')
  end

  scenario "A user edits an update that they can't manage" do
    login create :user
    project = create :project

    visit project_path(project)

    page.should_not have_selector('.edit-update')
  end
end
