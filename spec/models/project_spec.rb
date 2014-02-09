require 'spec_helper'

describe Project do
  it "knows who follows it" do
    user = create :user
    project = create :project
    user.follow(project)

    project.followers.should eq([user])
  end
end
