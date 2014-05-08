require 'spec_helper'

feature 'Deleting a comment' do
  let!(:post) { FactoryGirl.create(:post, user: create(:user)) }
  let!(:comment_to_delete) { FactoryGirl.create(:comment, post: post, author: "Delete Me") }
  let!(:second_comment) { FactoryGirl.create(:comment, post: post, author: "Don't Delete") }

  scenario do
    visit posts_path
    click_link post.title
    click_link comment_to_delete.author
    click_link "Delete Comment"
    expect(page).to have_content("Comment has been deleted.")
    expect(page).to_not have_content(comment_to_delete.author)
  end
end
