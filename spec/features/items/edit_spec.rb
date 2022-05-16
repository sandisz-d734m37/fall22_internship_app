require 'rails_helper'

describe "Item Edit Page" do
  before do
    @item1 = Item.create!(name: "Item 1", price: 1000, description: "The first item", inventory:10)

    visit "items/#{@item1.id}/edit"
  end

  it "comes with preloaded values" do
    expect(page).to have_field("Name", with: "Item 1")
    expect(page).to have_field("Description", with: "The first item")
    expect(page).to have_field("Price", with: 10.00)
    expect(page).to have_field("Inventory", with: 10)
  end

  it "redirects to item show page" do
    fill_in "Price", with: 0.50

    click_button "Update Item"

    expect(current_path).to eq("/items/#{@item1.id}")
    expect(page).to have_content("Price: $0.50")
    expect(page).not_to have_content("Price: $10.00")
  end

  it "redirects to back to edit page if name is blank" do
    fill_in "Name", with: ""

    click_button "Update Item"

    expect(current_path).to eq("/items/#{@item1.id}/edit")
    expect(page).to have_content("The name field cannot be blank")
  end

  it "inventory and price default to 0 if left blank" do
    fill_in "Price", with: ""
    fill_in "Inventory", with: ""

    click_button "Update Item"

    expect(current_path).to eq("/items/#{@item1.id}")
    expect(page).to have_content("Price: $0.00")
    expect(page).to have_content("Inventory: 0")
  end

  context "navigation" do
    it "has links to home page, item index, and shipment index" do
      expect(page).to have_link("Go to home page")
      expect(page).to have_link("Go to item index")
      expect(page).to have_link("Go to shipment index")
    end
  end
end
