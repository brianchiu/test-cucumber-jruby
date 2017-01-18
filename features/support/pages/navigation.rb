class Topbar < BasePage
	extend Capybara::DSL

	class << self
		def close_left_side_bar
			if left_side_bar_open?
				_left_side_bar_toggle.click
			end
		end

		def right_side_bar_open?
			page.has_xpath?("//a/span[text()='Applications']")
		end

		def left_side_bar_open?
			page.has_xpath?("//a/span[text()='Control Panel']")
		end

		def open_left_side_bar
			unless left_side_bar_open?
				_left_side_bar_toggle.click
			end
		end

		def open_right_side_bar
			_plus.click until right_side_bar_open?
		end

		# element finders

		def _add_link
			page.find("//span[text()='Add']/following-sibling::a")
		end

		def _plus
			page.find(:css, 'a span svg.lexicon-icon-plus')
		end

		def _left_side_bar_toggle
			page.find("//a[@data-qa-id='productMenu']")
		end
	end
end

class LeftSideBar < BasePage
	extend Capybara::DSL

	class << self
		def click_link(label)
			within(:css, '#productMenuSidebar') do
				super label
			end
		end

		def expand(menu_label)
			retry_method(2, Selenium::WebDriver::Error::StaleElementReferenceError) do
				within(:css, '#productMenuSidebar') do
					unless page.has_xpath?("//a[contains(.,'#{menu_label}') and @aria-expanded='true']")
						if menu_label == "Liferay DXP"
							page.click_link "_com_liferay_product_navigation_product_menu_web_portlet_ProductMenuPortlet_site_administrationToggler"
						else
							page.click_link menu_label
						end
					end
				end
			end
		end

		def select_from_public_pages_menu(item)
			_public_pages_menu.click
			page.click_link item
		end

		private

		def _public_pages_menu
			page.find("//a[text()='Public Pages']/following-sibling::div/a")
		end
	end
end

class RightSideBar < BasePage
	extend Capybara::DSL

	class << self
		def add_portlet(portlet)
			_application_toggle.click unless page.has_xpath?("//input[contains(@id,'searchApplication')]")
			_search_portlet_field.set(portlet)
			page.find("//span[@data-title='#{portlet}']", match: :first).hover
			_portlet_add(portlet).click
		end

		# element finders

		def _application_toggle
			page.find(:css, "a[data-qa-id='addMenuAddApplicationCategory']")
		end

		def _portlet_add(portlet)
			page.find("//span[@data-title='#{portlet}' and text()=' Add ']", match: :first)
		end

		def _search_portlet_field
			page.find("//input[contains(@id,'searchApplication')]")
		end
	end
end

class SiteNavigationPortlet
	extend Capybara::DSL

	class << self
		def has_active_page?(page_name)
			page.has_xpath?("//div[contains(@class,'navbar')]/ul/li[contains(@class,'active')]/a[contains(.,'#{page_name}')]")
		end
	end
end