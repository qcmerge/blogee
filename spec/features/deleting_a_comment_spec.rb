require 'spec_helper'

feature 'Deleting a comment' do
  let!(:post) { create(:post) }
  let!(:comment) { create(:comment, post: post) }
  let!(:comment2) { create(:comment, post: post) }

  scenario do
    visit posts_path
    click_link post.title
    click_link comment.author
    click_link "Delete Comment"
    expect(page).to have_content("Comment has been deleted.")
    expect(page).to_not have_content(comment.author)
  end
end
