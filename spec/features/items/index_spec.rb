require 'rails_helper'

describe "item index page" do
  before do
    @item1 = Item.create!(name: "Item 1", price: 1000, description: "The first item", inventory:10)
    @item2 = Item.create!(name: "Item 2", price: 2000, description: "The second item", inventory:20)
    @item3 = Item.create!(name: "Item 3", price: 3000, description: "The third item", inventory:30)

    visit "/items"
  end

  it "displays a list of items" do
    expect(page).to have_content("Item 1")
    expect(page).to have_content("Price: 10.00")

    expect(page).to have_content("Item 2")
    expect(page).to have_content("Price: 20.00")

    expect(page).to have_content("Item 3")
    expect(page).to have_content("Price: 30.00")
  end
end
