class Event < ActiveRecord::Base
	has_many :movies
	has_many :votes
	validates :location, presence: true
	validates :occurs_at, presence: true,
		                  uniqueness: { scope: :location,
		                  	message: 'already scheduled for that location'}
end
