require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'has a valid fixture' do 
  	@event = events(:january)
  	assert @event.valid?
  end
  	
  should have_many(:movies)
  should have_many(:votes)
  should validate_presence_of(:occurs_at)
  should validate_presence_of(:location)

  should validate_uniqueness_of(:occurs_at)
  .scoped_to(:location)
  .with_message('already scheduled for that location')
  .case_insensitive

  test 'event has winning movie' do 
    alien = movies(:alien)
    tron = movies(:tron)

    event = alien.event

    alien.vote('Joe')
    alien.vote('Rene')
    tron.vote('Lara')

    assert_equal event.winning_movie, alien
  end
end
