require "rails_helper"

describe "new shipment page" do
  before do
    @item1 = Item.create!(name: "Item 1", price: 1000, description: "The first item", inventory:10)
    @item2 = Item.create!(name: "Item 2", price: 2000, description: "The second item", inventory:20)
    @item3 = Item.create!(name: "Item 3", price: 3000, description: "The third item", inventory:30)

    visit "/shipments/new"
  end

  it "has a form to create a new shipment w auto-populated origin field" do
    fill_in "Destination", with: "123 Fake st"
    page.check('Outgoing')
    find(:css, "#selected_items_[value=#{@item1.id}]").set(true)
    find(:css, "#item_count_[class=#{@item1.id}]").fill_in with: 5
    find(:css, "#selected_items_[value=#{@item3.id}]").set(true)
    find(:css, "#item_count_[class=#{@item3.id}]").fill_in with: 5

    click_button "Create Shipment"

    expect(page).to have_content("Outgoing")
    expect(page).to have_content("Still en route")

    expect(page).not_to have_content("Incoming")
    expect(page).not_to have_content("Arrived")

    within("#items") do
      expect(page).to have_content("Item 1")
      expect(page).to have_content("Item 3")

      expect(page).not_to have_content("Item 2")
    end

    within("#totals") do
      expect(page).to have_content("Total items: 10")
      expect(page).to have_content("Total cost: $200.00")
    end
  end
end
