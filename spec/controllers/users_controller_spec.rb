require 'rails_helper'

RSpec.describe UsersController, type: :request do
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
      get users_path
      expect(response).to be_successful
    end

    it 'renders template index' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'renders template show' do
      get "/users/#{user1.id}"
      expect(response).to render_template(:show)
    end
  end
end
