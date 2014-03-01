class AddRatingScoreToLinks < ActiveRecord::Migration
  def change
    add_column :links, :rating_score, :bigint

    Link.find_each do |link|
      link.calculate_score
      link.save
    end

    change_column :links, :rating_score, :bigint, null: false
  end
end
