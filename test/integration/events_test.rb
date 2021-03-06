require 'test_helper'

class EventsTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:alice)
		sign_in(@user)

		@january = events(:january)
		@february = events(:february)

		visit events_path
	end

	def teardown
		Warden.test_reset!
	end

	test 'Index Page shows all events' do
		assert_equal events_path, current_path
		assert page.has_content?('Events')

		assert page.has_content?(@january.location)
		assert page.has_content?(@january.occurs_at)

		assert page.has_content?(@february.location)
		assert page.has_content?(@february.occurs_at)
	end

	test 'Can show an individual event' do 
		click_link @january.location

		assert_equal event_path(@january), current_path

		assert page.has_content?(@january.location)
		assert page.has_content?(@january.occurs_at)
	end

	test 'can Create events' do 
		event_time = 10.days.from_now

		click_link('Create Event')
		fill_in 'Location', with: 'Industry'
	end

	test 'can Update events' do 
		event_time = 20.days.from_now

		click_link @january.location
		find('.page-header').click_link 'Edit'

		fill_in 'Location', with: 'New Place'
		fill_in 'Date/Time', with: event_time

		click_button 'Update Event'

		assert page.has_content?('New Place')
		assert page.has_content?(event_time)
	end

	test 'can delete events' do 
		click_link @january.location
		find('.page-header').click_link 'Delete'

		assert_equal events_path, current_path

		refute page.has_content?(@january.location)
	end
end