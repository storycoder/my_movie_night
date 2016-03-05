require 'test_helper'

class VotesTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:alice)
    sign_in(@user)

    @january = events(:january)
    @alien = movies(:alien)
    @tron = movies(:tron)
    @lebowski = movies(:lebowski)

    visit event_path(@january)
  end

  def teardown
    Warden.test_reset!
  end
  
  test 'Event page shows how many votes each movie has' do 
  	assert find(".movie-list tr", text: alien.title).has_selector?("td", text "2")
  	assert find("movie-list tr", text: tron.title).has_selector?("td", text: 1)
  end

  test 'Event page allows you to vote on a movie' do 
  	find("movie-list tr", text: @alien.ttle).click_link("Vote")

  	assert_equal 3, alien.votes.count
  	assert find(".movie_list tr", text: @alien.title).has_selector?("td", text "3")
    assert find(".movie-list tr", text: @tron.title).has_selector?("td", text "1")
  end

  test 'event page shows who voted on movies' do 
    find("movie-list tr", test: @lebowski.title).click_link("Vote")

    vote_row = find(".vote-list tr", text: @lebowski.title)
  end
end
