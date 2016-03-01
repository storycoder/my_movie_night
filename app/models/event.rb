class Event < ActiveRecord::Base
	has_many :movies, dependent: :destroy
	has_many :votes, dependent: :destroy
	validates :location, presence: true
	validates :occurs_at, presence: true,
		                  uniqueness: { scope: :location,
		                  	message: 'already scheduled for that location'}
    def winning_movie
    	Vote.where(movie: movies).select(:movie_id).group(:movie_id).order('count(id) desc').first.movie
    end
end
