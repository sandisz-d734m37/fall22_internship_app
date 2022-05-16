require "rails_helper"

describe "Welcome page" do
  before do
    visit "/"
  end

  it "has a button to create a new item" do
    click_button("Create a new item")

    expect(current_path).to eq("/items/new")
  end

  it "has a button to create a new shipment if items exist" do
    expect(page).not_to have_button("Create a new shipment")

    Item.create!(name: "Item 1", price: 1000, description: "The first item", inventory:10)

    click_link("Go to home page")
    
    expect(page).to have_button("Create a new shipment")

    click_button("Create a new shipment")

    expect(current_path).to eq("/shipments/new")
  end

  context "navigation" do
    it "has links to home page, item index, and shipment index" do
      expect(page).to have_link("Go to home page")
      expect(page).to have_link("Go to item index")
      expect(page).to have_link("Go to shipment index")
    end
  end
end
