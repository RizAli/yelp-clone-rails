require 'rails_helper'

feature 'restaurants' do
  context 'when no restaurants have been created yet' do
    
    scenario 'Should display a prompt to add a new restaurant' do
      visit '/restaurants'
      expect(page).to have_link 'Add a new restaurant'
      expect(page).to have_content 'No restaurants added yet'
    end
  
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).not_to have_content 'No restaurants added yet'
      expect(page).to have_content 'KFC'
    end
  end

  context 'creating restaurants' do

    scenario 'a user must be logged in to create a restaurant' do
      visit '/restaurants'
      click_link 'Add a new restaurant'
      expect(current_path).to eq '/users/sign_in'
      expect(page).to have_content 'Sign in with Facebook'
    end

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Add a new restaurant'
      fill_in 'Name', with: 'Patty and Bun'
      click_button 'Create Restaurant'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Patty and Bun'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        sign_up
        visit '/restaurants'
        click_link 'Add a new restaurant'
        fill_in 'Name', with: 'A'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h1', text: 'A'
        expect(page).to have_content 'error'
      end
    end

  end

  context 'viewing restaurants' do

    let!(:patty_and_bun) {Restaurant.create(name: 'Patty and Bun')}

    scenario 'displays the individual page for the restaurant when you click on its name' do
      visit '/restaurants'
      click_link 'Patty and Bun'
      expect(page).to have_content 'Patty and Bun'
      expect(current_path).to eq "/restaurants/#{patty_and_bun.id}"
    end
  end

  context 'editing restaurants' do
    before {Restaurant.create name: 'KFC'}

    scenario 'lets a user edit a restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Kentucky Fried Chicken'
    end
  end

  context 'deleting restaurants' do
    before {Restaurant.create name: 'Beigel Bake'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_up
      visit '/restaurants'
      click_link 'Delete Beigel Bake'
      expect(current_path).to eq '/restaurants'
      expect(page).not_to have_content 'Beigel Bake'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
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