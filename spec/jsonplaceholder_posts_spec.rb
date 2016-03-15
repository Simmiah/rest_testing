require 'spec_helper'

describe 'Jsonplaceholder Posts' do
	it 'should return 200 response when getting posts' do
		result_posts = RestClient.get('http://jsonplaceholder.typicode.com/posts')
		expect(result_posts.code).to eql(200)
	end

	it 'should return 404 response when getting invalid post' do
		result_invalid = RestClient.get('http://jsonplaceholder.typicode.com/posts/invalid'){|response, request, result| result }
		expect(result_invalid.code).to eql("404")
	end

	it 'should return all posts when getting all posts' do
		expected_data = JSON.parse(IO.read('requests/all_posts.json'))
		result_all_posts = RestClient.get('http://jsonplaceholder.typicode.com/posts')
		expect(result_all_posts).to match_json_expression(expected_data)
	end

	it 'should return first post when getting post/1' do
		expected_data = JSON.parse(IO.read('requests/post1.json'))
		result_post1 = RestClient.get('http://jsonplaceholder.typicode.com/posts/1')
		expect(result_post1).to match_json_expression(expected_data)
	end

	it 'should return 201 when creating a new post' do
		post_response = RestClient.post('http://jsonplaceholder.typicode.com/posts', {
    		title: 'foo',
    		body: 'bar',
    		userId: 1
  		})
  		expect(post_response.code).to eql(201)
	end

	it 'should return 200 when updating post' do
		patch_response = RestClient.patch('http://jsonplaceholder.typicode.com/posts/1', {
    		title: 'Fooo'
  		})
  		expect(patch_response.code).to eql(200)
  	end
end