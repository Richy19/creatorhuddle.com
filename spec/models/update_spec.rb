require 'spec_helper'

describe Update do
  it 'makes sure that the user has permission to manage the updateable object' do
    user = create :user
    project = create :project
    update = build :update, updateable: project, user: user

    update.should_not be_valid
    update.errors[:base].should include("You can't manage updates for that!")
  end
end
