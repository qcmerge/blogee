require 'spec_helper'

feature "Viewing comments" do
  let!(:post1) { create(:post) }
  let!(:post2) { create(:post) }
  let!(:comment1) { create(:comment, post: post1) }
  let!(:comment2) { create(:comment, post: post2) }

  scenario do
    visit posts_path
    click_link post1.title
    within(".comments") do
      expect(page).to have_content(comment1.author)
      expect(page).to_not have_content(comment2.author)
    end
  end
end
