require 'rails_helper'

feature 'reviews' do
  before {Restaurant.create name: 'KFC'}
  
  scenario 'leaving a review' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Choked on some gristle..."
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Choked on some gristle...')
  end
end