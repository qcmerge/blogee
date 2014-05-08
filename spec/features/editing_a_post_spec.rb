require 'spec_helper'

feature 'Editing a post' do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  before do
    sign_in_as!(user)
    visit post_path(post)
    click_link 'Edit Post'
  end

  scenario 'with valid attributes' do
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
    fill_in 'Title', with: ''
    fill_in 'Content', with: ''
    click_button 'Save'

    expect(current_path).to eq edit_post_path(post)
    expect(page).to have_css('.alert.alert-danger')
  end

  scenario 'making a published post draft' do
    click_button 'Save as Draft'
    expect(page).to have_content('DRAFT')
  end

  context 'draft post' do
    let(:post) { create(:post, published_at: nil, user: user) }
    
    scenario 'publishing' do
      click_button 'Save'
      expect(page).to_not have_content('DRAFT')
    end
  end
end
