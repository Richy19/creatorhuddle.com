require 'spec_helper'

describe Link do
  it "score newer links higher" do
    link_1 = create :link, created_at: 10.days.ago
    link_2 = create :link

    link_1.calculate_score
    link_2.calculate_score

    (link_1.score < link_2.score).should be_true
  end

  it "scores links with more upvotes higher" do
    link_1 = create :link
    link_2 = create :link
    create :rating, ratable: link_2

    link_1.calculate_score
    link_2.calculate_score

    (link_1.score < link_2.score).should be_true
  end
end
