require 'test_helper'

class EventsTest < ActionDispatch::IntegrationTest
	test 'Index Page shows all events' do 
		january = events(:january)
		february = events(:february)

		visit events_path
		assert page.has_content?('Events')

		assert page.has_content?(january.location)
		assert page.has_content?(january.occurs_at)

		assert page.has_content?(february.location)
		assert page.has_content?(february.occurs_at)
	end

	test 'Can show an individual event' do 
		january = events(:january)
		visit events_path

		click_link january.location

		assert has_content?('Event')

		assert page.has_content?(january.location)
		assert page.has_content?(january.occurs_at)
	end

	test 'can Update events' do 
		event_time = 20.days.from_now

		january = events(:january)

		visit events_path

		click_link january.location
		click_link 'Edit Event'

		fill_in 'Location', with: 'New Place'
		fill_in 'Date/Time', with: event_time

		click_button 'Update Event'

		assert page.has_content?('New Place')
		assert page.has_content?(event_time)
	end

	test 'can delete events' do 
		january = events(:january)

		visit events_path

		click_link january.location
		click_link 'Delete Event'

		assert_equal events_path, current_path

		refute page.has_content?(january.location)
		refute page.has_content?(january.occurs_at)
	end
end