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
end