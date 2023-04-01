require 'rails_helper'

RSpec.describe Post, type: :model do
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

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not exceed 250 characters' do
    new_title = 'Lorem ipsum dolor sit amet consectetur adipisicing elit.
    Voluptatum laboriosam non ducimus perspiciatis quasi nulla esse,
    minima qui harum eligendi voluptatibus itaque vel atque! Error, aut
    nesciunt! Fugit consequatur consequuntur perspiciatis odit, alias laudantium quasi et accusamus vel tempora
    facilis cupiditate at quod reprehenderit veniam, assumenda asperiores sit! Expedita error recusandae, officiis
    maiores dolore delectus enim, voluptate consectetur cum sequi excepturi quos dignissimos. Veniam hic deleniti
    voluptatum expedita.'
    subject.title = new_title
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be positive' do
    subject.comments_counter = -10
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be positive' do
    subject.likes_counter = -10
    expect(subject).to_not be_valid
  end

  it 'shows at most 5 recent comments' do
    subject.comments = [
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text'),
      Comment.new(author: subject.author, post: subject, text: 'Any Text')
    ]
    expect(subject.most_recent_comments.length).to eql(5)
  end
end
