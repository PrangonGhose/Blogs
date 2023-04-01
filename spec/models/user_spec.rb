require 'rails_helper'
require 'rspec/rails'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Name', photo: 'Link', bio: 'Bio', posts_counter: 0) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'post_counter should be positive' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'shows at most 3 recent posts' do
    subject.posts = [
      Post.new(author: subject, title: 'New Title 1', text: 'This is my first post', comments_counter: 0,
               likes_counter: 0),
      Post.new(author: subject, title: 'New Title 2', text: 'This is my second post', comments_counter: 0,
               likes_counter: 0),
      Post.new(author: subject, title: 'New Title 3', text: 'This is my third post', comments_counter: 0,
               likes_counter: 0),
      Post.new(author: subject, title: 'New Title 4', text: 'This is my fourth post', comments_counter: 0,
               likes_counter: 0),
      Post.new(author: subject, title: 'New Title 5', text: 'This is my fifth post', comments_counter: 0,
               likes_counter: 0),
      Post.new(author: subject, title: 'New Title 6', text: 'This is my sixth post', comments_counter: 0,
               likes_counter: 0)
    ]
    expect(subject.recent_posts.length).to eql(3)
  end
end
