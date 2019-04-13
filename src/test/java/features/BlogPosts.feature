#----------------------------------
# Empty Cucumber .feature file
#----------------------------------
Feature: BlogPosts
   As a User I want to maintain BlogPosts In Order to access them efficiently

Background: Will be executed for each scenario
* def def_loc = 'https://jsonplaceholder.typicode.com/posts'  

Scenario: Get All Posts
Given url def_loc
When method get
Then status 200
Then assert response.length == 100
# Response status check
Then match responseStatus >= 200 && responseStatus <= 205
# Check id of the 2nd response
Then match response[1].id == 2
#Check that id collection has ids 1,2 & 3
Then match response[*].id contains [1,2,3]
# Check for each esponse that userId is present, id is numeric, ignore title and body
Then match each response == {id: '#number',userId: '#present', title: '#ignore', body: '#ignore'}
# Check id is of type number for each objet in response
Then match each response contains {id: '#number'}
# Check that Response is an array of 100 objects
Then match response == '#[]'
Then match response == '#[100]'
Then  def ids = $response[*].id
Then match ids contains [1]

# Print response in the test results
Scenario: Get Single Post
Given url def_loc
Given path '22'
When method get
Then status 200
Then print response

#http delete method
Scenario: Delete Single Post
Given url def_loc
Given path '3'
When method delete
Then status 200

#http post example comparing the response
Scenario: Add a post,compare response with expected result
* def result = {id:101,userId:10,title:'title', body:'content'}
Given url def_loc
Given def new_post = {userId:10, title:'title', body:'content'}
When request new_post
When method post
Then status 201
Then match response.id == 101
#Evaluate the response and compare with expected results
Then match response == result

# Read data from file
Scenario: Add a post, post data from file
* def result = {id:101,userId:10,title:'title', body:'content'}
Given url def_loc
#Given def new_post = {userId:10, title:'title', body:'content'}
When request read('new_post.json')
When method post
Then status 201
Then match response.id == 101

Scenario: Add a post, post data from file
* def result = {id:101,userId:10,title:'title', body:'content'}
Given url def_loc
#Given def new_post = {userId:10, title:'title', body:'content'}
When request read('posts.csv')
When method post
Then status 201
Then match response.id == 101

#Data driven test
#Use of variable placeholders & evaluation with #()
Scenario Outline: Add a post, data driven test
# Variable place holders within <>
* def newpost = {id:<id>,userId:<user>,title:<title>, body:<body>}
Given url def_loc
#Evaluation using examples
When request '#(newpost)'
When method post
Then status 201
Then match response.id == 101
# Dataset
Examples:
|id|user|title|body|
|1|1|abv|aaa|
|2|2|abs|aaa|

# Use of default variables from karate config (refer karate-config.js)
Scenario: Get posts by using global variables
Given url HOST
And path PATH_POSTS
When method get
Then status 200

#Use of headers in API tests
Scenario: Use headers
* def req_headers = {Content-Type: 'application/json', Connection: 'keep-alive'}
Given url HOST
And path PATH_POSTS, "1"
And headers req_headers
When method get
Then match response.id == 1

#Use of response in nscenario continuation
#Example test if a post is available before deleting
Scenario: Get a post and then delete, example of request chaining
* def req_headers = {Content-Type: 'application/json', Connection: 'keep-alive'}
Given url HOST
And path PATH_POSTS, "5"
And headers req_headers
When method get
Then match response.id == 5
And status 200

* def del_id = response.id
Given url HOST
And path PATH_POSTS, del_id
When method delete
Then status 200
