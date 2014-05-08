require 'spec_helper'

feature 'viewing posts' do
  let(:user) { create(:user) }
  let!(:post1) { create(:post, user: user, published_at: Date.today) }
  let!(:post2) { create(:post, user: user, published_at: nil) }

  before { visit posts_path }
  
  context 'signed in' do
    scenario 'should see all posts' do
      sign_in_as! user
      expect(page).to have_content(post1.title)
      expect(page).to have_content(post2.title)      
    end
  end

  context 'not signed in' do
    scenario 'should not see all posts' do
      expect(page).to have_content(post1.title)
      expect(page).to_not have_content(post2.title)
    end
  end
end
