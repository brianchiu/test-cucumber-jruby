Feature:  PortalSmoke

Scenario: Login
	Given I navigate to "http://localhost:8080"
	When I click the "Sign In" link
	And I enter "test@liferay.com" in the "Email Address" field
	And I enter "test" in the "Password" field
	And I click the "Sign In" button
	Then I logout