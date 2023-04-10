require 'rails_helper'

RSpec.describe 'Users Show Page', type: :feature do
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

  it 'Visit show page for user 1' do
    link = "/users/#{user1.id}"
    visit link
    expect(current_path).to eq(user_path(user1))
  end

  it 'Can show profile picture of user 1' do
    link = "/users/#{user1.id}"
    visit link
    expect(page).to have_css('img[src="https://www.bing.com/th?id=ODL.c83b34c2350e6cd3a1010f7d1998cfa8&w=143&h=198&c=12&rs=1&qlt=99&pcl=faf9f7&o=6&pid=13.1"]')
  end

  it 'Can show username of user 1' do
    link = "/users/#{user1.id}"
    visit link
    expect(page).to have_content(user1.name)
  end

  it 'Can show the number of posts of user 1' do
    link = "/users/#{user1.id}"
    visit link
    expect(page).to have_content(user1.posts_counter)
  end

  it 'Can show the bio of user 1' do
    link = "/users/#{user1.id}"
    visit link
    expect(page).to have_content(user1.bio)
  end

  it 'shows at most only 3 recent posts of user 1' do
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
    link = "/users/#{user1.id}"
    visit link
    expect(page).to have_content(user1.posts[5].text)
    expect(page).to have_no_content(user1.posts[0].text)
  end

  it 'Can show a button' do
    link = "/users/#{user1.id}"
    visit link
    expect(page).to have_button('See all posts')
  end

  it "Clicking on a user's post redirect to that post" do
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
    link = "/users/#{user1.id}"
    visit link
    click_on user1.posts[5].text
    expect(page).to have_current_path(user_post_path(user1, user1.posts[5]))
  end

  it 'Clicking the button takes to user 1 all posts' do
    link = "/users/#{user1.id}"
    visit link
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(user1))
  end

  it 'Visit show page for user 2' do
    link = "/users/#{user2.id}"
    visit link
    expect(current_path).to eq(user_path(user2))
  end

  it 'Can show profile picture of user 2' do
    link = "/users/#{user2.id}"
    visit link
    expect(page).to have_css('img[src="https://th.bing.com/th?q=Shahin+Artist&w=120&h=120&c=1&rs=1&qlt=90&cb=1&pid=InlineBlock&mkt=en-WW&cc=AF&setlang=en&adlt=strict&t=1&mw=247"]')
  end

  it 'Can show username of user 2' do
    link = "/users/#{user2.id}"
    visit link
    expect(page).to have_content(user2.name)
  end

  it 'Can show the number of posts of user 2' do
    link = "/users/#{user2.id}"
    visit link
    expect(page).to have_content(user2.posts_counter)
  end

  it 'Can show the bio of user 2' do
    link = "/users/#{user2.id}"
    visit link
    expect(page).to have_content(user2.bio)
  end

  it 'shows at most only 3 recent posts of user 2' do
    user2.posts = [
      Post.create(author: user2, title: 'New Title 1', text: 'This is my first post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 2', text: 'This is my second post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 3', text: 'This is my third post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 4', text: 'This is my fourth post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 5', text: 'This is my fifth post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 6', text: 'This is my sixth post', comments_counter: 0,
                  likes_counter: 0)
    ]
    link = "/users/#{user2.id}"
    visit link
    expect(page).to have_content(user2.posts[5].text)
    expect(page).to have_no_content(user2.posts[0].text)
  end

  it 'Can show a button' do
    link = "/users/#{user2.id}"
    visit link
    expect(page).to have_button('See all posts')
  end

  it "Clicking on a user's post redirect to that post" do
    user2.posts = [
      Post.create(author: user2, title: 'New Title 1', text: 'This is my first post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 2', text: 'This is my second post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 3', text: 'This is my third post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 4', text: 'This is my fourth post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 5', text: 'This is my fifth post', comments_counter: 0,
                  likes_counter: 0),
      Post.create(author: user2, title: 'New Title 6', text: 'This is my sixth post', comments_counter: 0,
                  likes_counter: 0)
    ]
    link = "/users/#{user2.id}"
    visit link
    click_on user2.posts[5].text
    expect(page).to have_current_path(user_post_path(user2, user2.posts[5]))
  end

  it 'Clicking the button takes to user 2 all posts' do
    link = "/users/#{user2.id}"
    visit link
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(user2))
  end
end
