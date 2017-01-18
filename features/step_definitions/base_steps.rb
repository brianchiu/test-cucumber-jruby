Given(/^I click the "([^"]*)" button$/) do |button|
	page.click_button button
end

Given(/^I click the "([^"]*)" link$/) do |link|
	page.click_link link
end

Given(/^I navigate to "([^"]*)"$/) do |url|
	visit url
end

Given(/^I enter "([^"]*)" in the "([^"]*)" field$/) do |text, field|
	page.fill_in field, with: text
end

Given(/^I logout$/) do
	page.find(:xpath, "(//*[@data-qa-id='openUserMenu'] | //span[@class='user-avatar-image'])[1]").click

	page.click_link "Sign Out"
end