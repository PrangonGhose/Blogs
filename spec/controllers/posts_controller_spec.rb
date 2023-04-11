require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'Get id' do
    let!(:user1) do
      User.create(
        name: 'Gio',
        photo: 'https://www.bing.com/th?id=ODL.c83b34c2350e6cd3a1010f7d1998cfa8&w=143&h=198&c=12&rs=1&qlt=99&pcl=faf9f7&o=6&pid=13.1',
        bio: 'CTO',
        posts_counter: 0
      )
    end

    it 'returns a successful response' do
      user1.posts = [
        Post.create(author: user1, title: 'New Title 1', text: 'This is my first post', comments_counter: 0,
                    likes_counter: 0),
        Post.create(author: user1, title: 'New Title 2', text: 'This is my second post', comments_counter: 0,
                    likes_counter: 0),
        Post.create(author: user1, title: 'New Title 3', text: 'This is my third post', comments_counter: 0,
                    likes_counter: 0),
        Post.create(author: user1, title: 'New Title 4', text: 'This is my fourth post', comments_counter: 0,
                    likes_counter: 0),
        Post.create(author: user1, title: 'New Title 5', text: 'This is my fifth post', comments_counter: 0,
                    likes_counter: 0),
        Post.create(author: user1, title: 'New Title 6', text: 'This is my sixth post', comments_counter: 0,
                    likes_counter: 0)
      ]
      get "/users/#{user1.id}/posts/#{user1.posts[0].id}/"
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'renders template index' do
      get users_path
      expect(response).to render_template(:index)
    end
  end
end
