require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @kfc = Restaurant.create(name: "KFC")
    @kfc.reviews.create(thoughts: "Nice food", rating: "4")
  end

  it "can be assigned to a specific restaurant" do
    expect(@kfc.reviews[0].thoughts).to eq 'Nice food'
  end

end
