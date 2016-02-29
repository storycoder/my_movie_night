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

end