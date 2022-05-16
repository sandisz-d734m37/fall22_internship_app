require 'rails_helper'

describe "New Item page" do
  before do
    visit "/items/new"
  end

  it "Has a form to create a new item then ridirects to item show page" do
    fill_in "Name", with: "Test Item"
    fill_in "Description", with: "Test item's description"
    fill_in "Price", with: 35.50
    fill_in "Inventory", with: 10

    click_button "Create Item"

    expect(page).to have_content("Test item")
    expect(page).to have_content("Description: Test item's description")
    expect(page).to have_content("Price: $35.50")
    expect(page).to have_content("Inventory: 10")
  end

  it "Redirects to /items/new and displays error message if name is blank" do
    fill_in "Description", with: "Failed item's description"
    fill_in "Price", with: 0.50
    fill_in "Inventory", with: 1

    click_button "Create Item"

    expect(current_path).to eq("/items/new")
    expect(page).to have_content("The name field cannot be blank")
  end

  it "Sets price and inventory to 0 if the field is left blank" do
    fill_in "Name", with: "Test item"

    click_button "Create Item"

    expect(page).to have_content("Test item")
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
