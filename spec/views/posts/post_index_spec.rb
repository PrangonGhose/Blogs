require 'rails_helper'

RSpec.describe 'Post Index Page', type: :feature do
  let!(:user1) do
    User.create(
      name: 'Gio',
      photo: 'https://www.bing.com/th?id=ODL.c83b34c2350e6cd3a1010f7d1998cfa8&w=143&h=198&c=12&rs=1&qlt=99&pcl=faf9f7&o=6&pid=13.1',
      bio: 'CTO',
      posts_counter: 0
    )
  end

  let!(:user2) do
    User.create(
      name: 'Frank',
      photo: 'https://th.bing.com/th?q=Shahin+Artist&w=120&h=120&c=1&rs=1&qlt=90&cb=1&pid=InlineBlock&mkt=en-WW&cc=AF&setlang=en&adlt=strict&t=1&mw=247',
      bio: 'Tech',
      posts_counter: 0
    )
  end

  it 'Can show profile picture of user 1' do
    link = "/users/#{user1.id}/posts"
    visit link
    expect(page).to have_css('img[src="https://www.bing.com/th?id=ODL.c83b34c2350e6cd3a1010f7d1998cfa8&w=143&h=198&c=12&rs=1&qlt=99&pcl=faf9f7&o=6&pid=13.1"]')
  end

  it 'Can show username of user 1' do
    link = "/users/#{user1.id}/posts"
    visit link
    expect(page).to have_content(user1.name)
  end

  it 'does all tests for posts of user 1' do
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
    user1.posts[5].comments = [
      Comment.create(author: user1.posts[5].author, post: user1.posts[5], text: 'Any Text'),
      Comment.create(author: user1.posts[5].author, post: user1.posts[5], text: 'Any Text'),
      Comment.create(author: user1.posts[5].author, post: user1.posts[5], text: 'Any Text'),
      Comment.create(author: user1.posts[5].author, post: user1.posts[5], text: 'Any Text'),
      Comment.create(author: user1.posts[5].author, post: user1.posts[5], text: 'Any Text'),
      Comment.create(author: user1.posts[5].author, post: user1.posts[5], text: 'Any Text')
    ]
    link = "/users/#{user1.id}/posts"
    visit link
    expect(page).to have_content(user1.posts_counter) # can see the number of posts the user has written
    visit link
    expect(page).to have_content(user1.posts[5].title) # can see a post's title
    visit link
    expect(page).to have_content(user1.posts[5].comments_counter) # can see how many comments a post has
    expect(page).to have_content(user1.posts[5].likes_counter) # can see how many likes a post has
    visit link
    click_on user1.posts[5].text
    expect(page).to have_current_path(user_post_path(user1, user1.posts[5])) # it redirects me to that post's show page
    visit link
    expect(page).to have_content(user1.posts[5].text) # can see some of the post's body
    expect(page).to have_content(user1.posts[4].text) # can see some of the post's body
    expect(page).to have_content(user1.posts[3].text) # can see some of the post's body
    visit link
    expect(page).to have_content(user1.posts[5].comments[0].text) # can see the first comments on a post
  end

  it 'Can show a pagination button' do
    link = "/users/#{user1.id}/posts"
    visit link
    expect(page).to have_button('Pagination')
  end

  it 'Can show profile picture of user 2' do
    link = "/users/#{user2.id}/posts"
    visit link
    expect(page).to have_css('img[src="https://th.bing.com/th?q=Shahin+Artist&w=120&h=120&c=1&rs=1&qlt=90&cb=1&pid=InlineBlock&mkt=en-WW&cc=AF&setlang=en&adlt=strict&t=1&mw=247"]')
  end

  it 'Can show username of user 2' do
    link = "/users/#{user2.id}/posts"
    visit link
    expect(page).to have_content(user2.name)
  end

  it 'does all tests for posts of user 2' do
    user2.posts = [
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
    user2.posts[5].comments = [
      Comment.create(author: user2.posts[5].author, post: user2.posts[5], text: 'Any Text'),
      Comment.create(author: user2.posts[5].author, post: user2.posts[5], text: 'Any Text'),
      Comment.create(author: user2.posts[5].author, post: user2.posts[5], text: 'Any Text'),
      Comment.create(author: user2.posts[5].author, post: user2.posts[5], text: 'Any Text'),
      Comment.create(author: user2.posts[5].author, post: user2.posts[5], text: 'Any Text'),
      Comment.create(author: user2.posts[5].author, post: user2.posts[5], text: 'Any Text')
    ]
    link = "/users/#{user2.id}/posts"
    visit link
    expect(page).to have_content(user2.posts_counter) # can see the number of posts the user has written
    visit link
    expect(page).to have_content(user2.posts[5].title) # can see a post's title
    visit link
    expect(page).to have_content(user2.posts[5].comments_counter) # can see how many comments a post has
    expect(page).to have_content(user2.posts[5].likes_counter) # can see how many likes a post has
    visit link
    click_on user2.posts[5].text
    expect(page).to have_current_path(user_post_path(user2, user2.posts[5])) # it redirects me to that post's show page
    visit link
    click_on user2.posts[5].text
    expect(page).to have_current_path(user_post_path(user2, user2.posts[5]))
    visit link
    expect(page).to have_content(user2.posts[5].text) # can see some of the post's body
    expect(page).to have_content(user2.posts[4].text) # can see some of the post's body
    expect(page).to have_content(user2.posts[3].text) # can see some of the post's body
    visit link
    expect(page).to have_content(user2.posts[5].comments[0].text) # can see the first comments on a post
  end

  it 'Can show a pagination button' do
    link = "/users/#{user2.id}/posts"
    visit link
    expect(page).to have_button('Pagination')
  end
end
