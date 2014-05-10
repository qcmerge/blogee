require 'spec_helper'

feature 'Creating posts' do
  let(:user) { create(:user) }

  before do
    sign_in_as! user
    visit posts_path
    click_link 'New Post'
  end

  def fill_post_details
    fill_in 'Title', with: 'My First Post'
    fill_in 'Content', with: 'Lorem ipsum dolor sit amet.'
  end

  scenario 'with valid attributes' do
    fill_post_details
    click_button 'Save'
    expect(Post.count).to eq 1
    post = Post.last
    expect(current_path).to eq post_path(post)
    expect(post.title).to eq 'My First Post'

    within "#author" do
      expect(page).to have_content("By: #{user.username}")
    end
  end

  scenario 'with invalid attributes' do
    click_button 'Save'
    expect(current_path).to eq new_post_path
    expect(page).to have_css('.alert.alert-danger')
  end

  scenario "Creating a post with an attachment" do
    fill_post_details

    attach_file "File", "spec/fixtures/mogester1.jpg"
    click_button "Save"

    expect(page).to have_content("My First Post")

    within("#asset") do
      expect(page).to have_content("mogester1.jpg")
    end
  end

  scenario "creating a draft post" do
    fill_post_details
    click_button 'Save as Draft'
    expect(Post.last.published_at).to be_nil
    expect(page).to have_content('DRAFT')
  end

  scenario "Creating a post with tags" do
    fill_post_details

    fill_in 'post_tag_names', with: 'browser visual'
    click_button "Save"

    within("#tags") do
      expect(page).to have_content("browser")
      expect(page).to have_content("visual")
    end
  end
end
