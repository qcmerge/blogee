require 'spec_helper'

feature "Viewing comments" do
  let!(:post) { FactoryGirl.create(:post, user: FactoryGirl.create(:user)) }
  let!(:comment) { FactoryGirl.create(:comment, post: post, author: "Find this") }
  let!(:other_post) { FactoryGirl.create(:post, user: FactoryGirl.create(:user)) }
  let!(:other_comment) { FactoryGirl.create(:comment, post: other_post) }

  scenario do
    visit posts_path
    click_link post.title
    within(".comments") do
      expect(page).to have_content(comment.author)
      expect(page).to_not have_content(other_comment.author)
    end
  end
end
