require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @all_reviews = Review.all
    @kfc = Restaurant.create(name: "KFC")
    @kfc.reviews.create(thoughts: "Nice food", rating: "4")
  end

  it "can be assigned to a specific restaurant" do
    expect(@kfc.reviews[0].thoughts).to eq 'Nice food'
  end

  it "is also deleted when the associated restaurant is deleted" do
    @kfc.destroy
    expect(@all_reviews).not_to include "Nice food"
  end

end
