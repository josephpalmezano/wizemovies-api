class Review < ApplicationRecord
  default_scope { order(:created_at) }

  belongs_to :movie

  validates :title, :rating, :content, presence: true
  validates :rating, numericality: {
                                    only_integer: true, 
                                    less_than_or_equal_to: 5, 
                                    greater_than_or_equal_to: 1, 
                                    message: "invalid" 
                                   }
end

# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  content    :text
#  rating     :integer          default(0)
#  title      :string
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#
# Indexes
#
#  index_reviews_on_movie_id  (movie_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#
