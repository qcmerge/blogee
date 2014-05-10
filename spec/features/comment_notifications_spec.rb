require 'spec_helper'

feature 'Author notifications' do
  let!(:author) { create(:user) }
  let!(:post) { create(:post, user: author) }

  before do
    ActionMailer::Base.deliveries.clear

    visit post_path(post)
    click_link "Add Comment"
    fill_in "Author", with: "Anonymous Internet User"
    fill_in "Content", with: "You're wrong! This is the Internet - whatever you say is wrong."
    click_button "Add Comment"
  end

  scenario 'notifying author after new comment posted' do

    email = find_email!(author.email)
    subject = "You got a new comment!"
    email.subject.should include(subject)

  end

end
