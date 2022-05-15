require 'rails_helper'

describe "item index page" do
  before do
    @item1 = Item.create!(name: "B Item 1", price: 1000, description: "The first item", inventory:10)
    @item2 = Item.create!(name: "C Item 2", price: 2000, description: "The second item", inventory:20)
    @item3 = Item.create!(name: "A Item 3", price: 3000, description: "The third item", inventory:30)

    visit "/items"
  end

  it "displays a list of items" do
    expect(page).to have_content("B Item 1")
    expect(page).to have_content("Price: $10.00")
    expect(page).to have_content("Inventory: 10")

    expect(page).to have_content("C Item 2")
    expect(page).to have_content("Price: $20.00")
    expect(page).to have_content("Inventory: 20")


    expect(page).to have_content("A Item 3")
    expect(page).to have_content("Price: $30.00")
    expect(page).to have_content("Inventory: 30")
  end

  it "displays the items in order" do
    expect("A Item 3").to appear_before("B Item 1")
    expect("B Item 1").to appear_before("C Item 2")
  end

  it "includes links to item show pages" do
    within("#item-#{@item1.id}") do
      click_link("B Item 1")
      expect(current_path).to eq("/items/#{@item1.id}")
    end
  end
end
