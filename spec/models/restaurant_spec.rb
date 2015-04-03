require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'Ab')
    expect(restaurant).not_to be_valid
    expect(restaurant).to have(1).error_on(:name)
  end

  it 'is not valid if it already exists in the database' do
    Restaurant.create(name: 'KFC')
    restaurant = Restaurant.new(name: 'KFC')
    expect(restaurant).not_to be_valid
    expect(restaurant).to have(1).error_on(:name)
  end
end
