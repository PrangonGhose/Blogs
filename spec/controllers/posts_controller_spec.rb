require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'Get id' do
    it 'returns a successful response' do
      get '/users/:id/posts/:id/'
      expect(response).to be_successful
    end

    it 'renders template index' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'renders template show' do
      get '/users/:id/posts/:id'
      expect(response).to render_template(:show)
    end

    it ' the response body includes correct placeholder text' do
      get '/users/:id/posts'
      expect(response.body).to include('Here is a list of posts for a given user')
    end

    it ' the response body includes correct placeholder text' do
      get '/users/:id/posts/:id'
      expect(response.body).to include('Here is the selected post for a given user')
    end
  end
end
