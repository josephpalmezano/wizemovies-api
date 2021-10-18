class Movie < ApplicationRecord
	has_many :reviews
	has_and_belongs_to_many :genres

	validates :title, presence: true

	def rating
		reviews.average(:rating).to_f.ceil(1)
	end
end

# == Schema Information
#
# Table name: movies
#
#  id         :bigint           not null, primary key
#  plot       :text
#  poster_url :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
