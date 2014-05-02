require 'spec_helper'

feature 'Deleting a comment' do
  let!(:post) { FactoryGirl.create(:post, user: create(:user)) }
  let!(:comment_to_delete) { FactoryGirl.create(:comment, post: post, author: "Delete Me") }
  let!(:second_comment) { FactoryGirl.create(:comment, post: post, author: "Don't Delete") }

  scenario do
    visit post_path(post)
    click_link comment_to_delete.author
    click_link "Delete Comment"

    # assert that Comment.count decreased by 1

    expect(current_path).to eq post_path(post)
    expect(page).to_not have_content("Delete Me")
    expect(page).to have_content("Don't Delete")
  end
end
