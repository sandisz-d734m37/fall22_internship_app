require 'rails_helper'

describe "Item Edit Page" do
  before do
    @item1 = Item.create!(name: "Item 1", price: 1000, description: "The first item", inventory:10)

    visit "items/#{@item1.id}/edit"
  end

  it "comes with preloaded values" do
    expect(page).to have_selector("Name", value: "Item 1")
    expect(page).to have_selector("Description", value: "The first item")
    expect(page).to have_selector("Price", value: 10.00)
    expect(page).to have_selector("Inventory", value: 10)
  end
end
