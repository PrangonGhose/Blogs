require 'rails_helper'

RSpec.describe Comment, type: :model do
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

  it 'Each comment must increase the value of comments_counter' do
    subject.comments = [
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text')
    ]
    expect(subject.comments_counter).to eql(6)
  end
end
