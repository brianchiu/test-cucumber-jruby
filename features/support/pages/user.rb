class User
	extend Capybara::DSL

	class << self
		def signin(email)
			visit Capybara.app_host
			page.click_link "Sign In"
			page.fill_in "Email Address", with: email
			page.fill_in "Password", with: "test"
			page.click_button "Sign In"

			if page.has_text? "Password Reminder"
				page.fill_in "Answer", with: "test"
				page.click_button "Save"
			end
		end
	end
end