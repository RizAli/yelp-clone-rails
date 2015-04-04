require 'rails_helper'

feature 'reviews' do
  before {Restaurant.create name: 'KFC'}
  
  scenario 'leaving a review' do
    sign_up
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Choked on some gristle..."
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Choked on some gristle...')
  end
end

#### Helper methods

def sign_up
  visit '/users/sign_up'
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'testtest'
  fill_in 'Password confirmation', with: 'testtest'
  click_button 'Sign up'
end