class MoviesController < ApplicationController
	before_action :authenticate_user!

	def create
		@event = Event.find(params[:event_id])
		@movie = @event.movies.build(movie_params)

		if @movie.save
			redirect_to @event, notice: 'Movie created successfully'
		else
			render 'events/show'
		end
	end

	def destroy
		@event = Event.find(params[:event_id])
		@movie = @event.movies.build(movie_params)

		@movie.destroy
		redirect_to @event, notice: 'Movie deleted successfully'
	end

	def vote
		@event = Event.find(params[:event_id])
		@movie = Movie.find(params[:id])
		@vote = @movie.vote(current_user)

		respond_to do |format|
			format.html do
				redirect_to @event, notice: "Voted for #{@movie.title}"
			end
			format.js
		end
	end

	private

		def movie_params
			params.require(:movie).permit(:event_id, :title, :url)
		end
end
