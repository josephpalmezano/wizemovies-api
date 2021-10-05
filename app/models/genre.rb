class Genre < ApplicationRecord
  has_and_belongs_to_many :movies

  validates :name, :the_movie_db_id, presence: true
  validates :the_movie_db_id, numericality: { only_integer: true, message: "invalid" }
  validates :the_movie_db_id, uniqueness: true
end

# == Schema Information
#
# Table name: genres
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  the_movie_db_id :integer          not null
#
