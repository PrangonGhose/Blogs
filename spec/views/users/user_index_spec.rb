require 'rails_helper'

RSpec.describe 'Main Page', type: :feature do
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

  it 'signs @user /users/ in home' do
    visit '/'
    expect(current_path).to eq(root_path)
  end

  it 'checks username' do
    visit '/'
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
  end

  it 'checks profile picture' do
    visit '/'
    expect(page).to have_css('img[src="https://www.bing.com/th?id=ODL.c83b34c2350e6cd3a1010f7d1998cfa8&w=143&h=198&c=12&rs=1&qlt=99&pcl=faf9f7&o=6&pid=13.1"]')
    expect(page).to have_css('img[src="https://th.bing.com/th?q=Shahin+Artist&w=120&h=120&c=1&rs=1&qlt=90&cb=1&pid=InlineBlock&mkt=en-WW&cc=AF&setlang=en&adlt=strict&t=1&mw=247"]')
  end

  it 'checks number of posts' do
    visit '/'
    expect(page).to have_content(user1.posts_counter)
    expect(page).to have_content(user2.posts_counter)
  end

  it 'clicking on user 1' do
    visit '/'
    click_on user1.name
    expect(page).to have_current_path(user_path(user1))
  end

  it 'clicking on user 2' do
    visit '/'
    click_on user2.name
    expect(page).to have_current_path(user_path(user2))
  end
end
