Feature:  Workflow Admin Web Content Display
	Any description you want over here.

Background:
	Given I sign in to Liferay Portal as "test@liferay.com"

Scenario:  Approve Web Content Via Web Content Display
	Given I go to "Content" > "Web Content" in the Product Menu
	And I configure workflow via folder info for "Single Approver (Version 1)"
	And I add a new page named "Web Content Display Page"
	And I add a "Web Content Display" portlet to the page
	When I add the following Web Content with workflow via Web Content Display
		| WC Webcontent Content | WC WebContent Title |
	Then I should see the following Web Content is "Pending (Review)"
		| WC Webcontent Content | WC WebContent Title |
	When I go to "My Account" > "My Workflow Tasks" in the User Menu
	And I assign to myself a "Review" task for the following Web Content
		| WC Webcontent Content | WC WebContent Title |
	And I go to the page "Web Content Display Page"
	Then I should see the following Web Content is "Pending (Review)"
		| WC Webcontent Content | WC WebContent Title |
	When I go to "My Account" > "My Workflow Tasks" in the User Menu
	And I approve the following Web Content
		| WC Webcontent Content | WC WebContent Title |
	And I go to the page "Web Content Display Page"
	Then I should see the following Web Content displayed in the portlet
		| WC Webcontent Content | WC WebContent Title |