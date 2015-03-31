require 'rails_helper'

feature 'restaurants' do
  context 'when no restaurants have been created yet' do
    
    scenario 'Should display a prompt to add a new restaurant' do
      visit '/restaurants'
      expect(page).to have_link 'Add a new restaurant'
      expect(page).to have_content 'No restaurants added yet'
    end
  
  end
end