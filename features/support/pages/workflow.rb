class MyWorkflowTasks < BasePage
end

class MyWorkflowTasksTask < BasePage
	extend Capybara::DSL

	class << self
		def add_comment(text="")
			within(:css, '.modal-content') do
				page.fill_in "Comment", with: text
				page.click_button "Done"
			end
		end
	end
end