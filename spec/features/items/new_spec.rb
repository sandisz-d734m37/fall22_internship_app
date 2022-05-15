require 'rails_helper'

describe "New Item page" do
  it "I see a form to create a new item then ridirects to item show page" do
    visit "/items/new"

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
end
