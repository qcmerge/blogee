require 'spec_helper'

feature "Viewing comments" do
  let!(:post) { FactoryGirl.create(:post, user: FactoryGirl.create(:user)) }
  let!(:comment) { FactoryGirl.create(:comment, post: post, author: "Find this") }
  let!(:other_post) { FactoryGirl.create(:post, user: FactoryGirl.create(:user)) }
  let!(:other_comment) { FactoryGirl.create(:comment, post: other_post) }

  scenario do
    visit posts_path
    click_link post1.title
    within(".comments") do
      expect(page).to have_content(comment1.author)
      expect(page).to_not have_content(comment2.author)
    end
  end
end
