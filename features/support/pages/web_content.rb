class WebContent < BasePage
	extend Capybara::DSL

	class << self
		def click_info_button
			info_button.click until page.has_css?('.sidenav-right.open')
		end

		def click_info_ellipsis
			info_vertical_ellipsis.click
		end

		def select_from_info_ellipsis_menu(item)
			page.find("//a/span[text()='#{item}']").click
		end

		def select_workflow(option)
			page.select "#{option}", from: '_com_liferay_journal_web_portlet_JournalPortlet_workflowDefinition-1'
		end

		private

		def info_button
			page.find(:css, "a[data-qa-id='infoButton']", wait: 60)
		end

		def info_vertical_ellipsis
			within("//div[contains(@class,'portlet') and contains(@class,'container')]", wait: 60) do
				vertical_ellipsis
			end
		end
	end
end

class WebContentDetail < BasePage
	extend Capybara::DSL

	class << self

		def has_content?(content)
			_content_field.value == content
		end

		def has_title?(title)
			_title_field.value == title
		end

		def _content_field
			page.find("//div[contains(@data-placeholder,'Write your content here...')]")
		end

		def _title_field
			page.find("//input[contains(@id,'title')]")
		end

		def _workflow_status
			page.find(:css, '.workflow-status span')
		end
	end
end

class WebContentDisplayPortlet < BasePage
	extend Capybara::DSL

	class << self
		def add_basic_web_content(content, title)
			_portlet_title.hover
			_plus.click
			page.find("//span[text()='Basic Web Content']").click
			within_frame(find(:css, '.dialog-iframe-node')) do
				page.fill_in "Title", with: title
				WebContentDetail._content_field.set content
				page.click_button "Submit for Publication"
			end
		end

		def click_warning_message
			page.find(:css, '.alert.alert-warning a').click
		end

		def has_warning_message?(message)
			within("//section[contains(@id,'JournalContentPortlet')]") do
				super message
			end
		end

		def _plus
			page.find("//*[@data-qa-id='addButton']//a[contains(@id,'JournalContent')]")
		end

		def _portlet_title
			page.find("//span[@class='portlet-name-text' and text()='Web Content Display']", visible: false)
		end

		def _webcontent_content
			page.find("//div[@class='journal-content-article']")
		end

		def _webcontent_title
			page.find(:css, 'h2.portlet-title-text')
		end
	end
end