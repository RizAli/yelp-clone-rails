require 'rails_helper'

context 'user not signed in and on the homepage' do
  before {visit '/'}

  it 'should see a Sign in and Sign Up link' do
    expect(page).to have_link 'Sign in'
    expect(page).to have_link 'Sign up'
  end

  it 'should not see a Sign out link' do
    expect(page).not_to have_content 'Sign out'
  end
end

context "user signed in on the homepage" do

  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  it "should see 'sign out' link" do
    visit('/')
    expect(page).to have_link('Sign out')
  end

  it "should not see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end

  it "can only leave one review per restaurant" do
    leave_kfc_review
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Choked on some gristle..."
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content "You can only write one review per restaurant"
  end

  context "editing and deleting restaurants" do
    it "can't edit or delete restaurants they didn't create" do
      leave_kfc_review
      click_link 'Sign out'
      click_link('Sign up')
      fill_in('Email', with: 'test2@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      expect(page).not_to have_content "Edit KFC"
      expect(page).not_to have_content "Delete KFC"
    end
  end
end


#### Helper methods

def leave_kfc_review
  Restaurant.create name: 'KFC'
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in "Thoughts", with: "Choked on some gristle..."
  select '3', from: 'Rating'
  click_button 'Leave Review'
end