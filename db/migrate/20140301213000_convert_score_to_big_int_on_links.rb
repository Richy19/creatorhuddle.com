class ConvertScoreToBigIntOnLinks < ActiveRecord::Migration
  def change
    change_column :links, :score, :bigint, null: false
  end
end
