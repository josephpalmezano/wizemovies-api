class ChangeRatingFromReviews < ActiveRecord::Migration[6.1]
  def change
    change_column(:reviews, :rating, :integer, default: 0)
  end
end
