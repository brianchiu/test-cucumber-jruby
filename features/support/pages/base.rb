class BasePage
	extend Capybara::DSL

	class << self
		def click_button(label)
			page.click_button label
		end

		def click_link(label)
			page.click_link label
		end

		def fill_in(field, text)
			page.fill_in field, with: text
		end

		def has_success_message?(message)
			within(:css, '.alert-success') do
				page.has_text? message
			end
		end

		def has_warning_message?(message)
			within(:css, '.alert.alert-warning') do
				page.has_text? message
			end
		end

		def vertical_ellipsis
			page.find(:css, 'a span svg.lexicon-icon-ellipsis-v', wait: 60)
		end
	end
end

class AddNewPage < BasePage
end