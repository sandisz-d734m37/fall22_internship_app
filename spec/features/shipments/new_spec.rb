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

  it "will be incoming if 'outging' check box is not checked" do
    fill_in "Destination", with: "123 Fake st"
    find(:css, "#selected_items_[value=#{@item1.id}]").set(true)
    find(:css, "#item_count_[class=#{@item1.id}]").fill_in with: 5

    click_button "Create Shipment"

    expect(page).to have_content("Incoming")

    expect(page).not_to have_content("Outgoing")
  end

  it "will decrease item inventory when outgoing shipment is created" do
    fill_in "Destination", with: "123 Fake st"
    page.check('Outgoing')
    find(:css, "#selected_items_[value=#{@item1.id}]").set(true)
    find(:css, "#item_count_[class=#{@item1.id}]").fill_in with: 5

    click_button "Create Shipment"

    expect(page).to have_content("Outgoing")
    expect(page).to have_content("Still en route")

    within("#items") do
      click_link("Item 1")
    end

    expect(page).to have_content("Inventory: 5")
    expect(page).not_to have_content("Inventory: 10")
  end

  it "will increase item inventory when incoming shipment is created" do
    fill_in "Origin", with: "123 Fake st"
    fill_in "Destination", with: "123 Real Corp st"
    find(:css, "#selected_items_[value=#{@item1.id}]").set(true)
    find(:css, "#item_count_[class=#{@item1.id}]").fill_in with: 5

    click_button "Create Shipment"

    expect(page).to have_content("Incoming")
    expect(page).to have_content("Still en route")

    within("#items") do
      click_link("Item 1")
    end

    expect(page).to have_content("Inventory: 15")
    expect(page).not_to have_content("Inventory: 10")
  end
end
