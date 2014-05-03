require 'spec_helper'

feature 'Editing a post' do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  before { sign_in_as!(user) }

  scenario 'with valid attributes' do
    visit post_path(post)
    click_link 'Edit Post'
    expect(current_path).to eq edit_post_path(post)

    fill_in 'Title', with: 'Zombie Ipsum!!!'
    fill_in 'Content', with: 'Zombies reversus ab inferno, nam malum cerebro.'

    click_button 'Save'

    post.reload

    expect(current_path).to eq post_path(post)
    expect(post.title).to eq 'Zombie Ipsum!!!'
    expect(post.content).to eq 'Zombies reversus ab inferno, nam malum cerebro.'
    expect(post.user).to eq user
  end

  scenario 'with invalid attributes' do
    visit post_path(post)
    click_link 'Edit Post'

    fill_in 'Title', with: ''
    fill_in 'Content', with: ''
    click_button 'Save'

    expect(current_path).to eq edit_post_path(post)
    expect(page).to have_css('.alert.alert-danger')
  end
end
