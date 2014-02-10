require 'spec_helper'

describe Comment do
  it "can be nested" do
    comment = create :comment
    comment2 = create :comment, parent: comment

    comment.children.should eq([comment2])
  end

  it "can be added to an update" do
    update = create :update
    comment = create :comment, commentable: update

    update.comments.should eq([comment])
  end
end
