require 'spec_helper'

describe 'Jsonplaceholder comments' do
	it 'should return 200 response when getting comments' do
		result_posts = RestClient.get('http://jsonplaceholder.typicode.com/comments')
		expect(result_posts.code).to eql(200)
	end

	it 'should return 404 response when getting invalid comment' do
		result_invalid = RestClient.get('http://jsonplaceholder.typicode.com/comments/invalid'){|response, request, result| result }
		expect(result_invalid.code).to eql("404")
	end

	it 'should return all comments when getting all comments' do
		expected_data = JSON.parse(IO.read('requests/all_comments.json'))
		result_all_posts = RestClient.get('http://jsonplaceholder.typicode.com/comments')
		expect(result_all_posts).to match_json_expression(expected_data)
	end

	it 'should return all comments for a given post' do
		expected_data = JSON.parse(IO.read('requests/post1_comments.json'))
		result_post1_comments = RestClient.get('http://jsonplaceholder.typicode.com/posts/1/comments')
		expect(result_post1_comments).to match_json_expression(expected_data)
	end
end