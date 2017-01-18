require 'rubygems'
require 'capybara/cucumber'
require 'report_builder'
require 'pry-byebug' if ENV['DEBUG']

# set chrome as default driver
Capybara.register_driver :selenium do |app|
  	Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium

# set base url
Capybara.app_host = 'http://localhost:8080'

Capybara.default_max_wait_time = 3

#Capybara.javascript_driver = :chrome

# set xpath as default selector
Capybara.default_selector = :xpath

# set browser window size
def set_selenium_window_size(width, height)
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(width, height)
end

set_selenium_window_size(1300, 768)

at_exit do
	ReportBuilder.configure do |config|
	config.json_path = 'json-report'
    # config.report_path = "html-report/#{Time.now.strftime('%m%d%Y%H%M')}"
	config.report_path = "html-report/report"
	config.report_types = [:html]
	config.report_tabs = [:overview, :features, :scenarios, :errors]
	config.report_title = 'Portal Test Results'
	config.compress_images = false
	end

	ReportBuilder.build_report
end
