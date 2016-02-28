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

end