#----------------------------------
# Empty Cucumber .feature file
#----------------------------------
Feature: With a secure key

Scenario: Basic access example
* def req_headers = {app_id: '{}', app_key: '{}'}
Given url 'https://od-api.oxforddictionaries.com/api/v1/entries/en/hello'
And headers req_headers
When method get
Then status 200

Scenario: Get Token
Given url 'https://graph.facebook.com/oauth/access_token?client_id={}&client_secret={}&grant_type=client_credentials'
When method get
Then status 200

* def token = response.access_token
* def token_type =  response.token_type
Given url  'https://graph.facebook.com/me/photo'
Given param access_token = '#(token)'
When method get
Then status 200
Then print response

    

   
