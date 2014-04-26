require 'spec_helper'

feature "signing in" do
  scenario 'with username' do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Sign in'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")
  end

  scenario 'with email address' do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Sign in'
    fill_in 'Username', with: user.email
    fill_in 'Password', with: user.password
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")
  end
end
