require 'rails_helper'

RSpec.describe Like, type: :model do
  subject do
    Post.new(
      author: User.new(name: 'Name', photo: 'Link', bio: 'Bio', posts_counter: 0),
      title: 'post title',
      text: 'posts text',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  before { subject.save }

  it 'Each like must increase the value of likes_counter' do
    subject.likes = [
      Like.new(author: subject.author, post: subject),
      Like.new(author: subject.author, post: subject),
      Like.new(author: subject.author, post: subject),
      Like.new(author: subject.author, post: subject),
      Like.new(author: subject.author, post: subject),
      Like.new(author: subject.author, post: subject)
    ]
    expect(subject.likes_counter).to eql(6)
  end
end
