require 'rails_helper'

describe "item show page" do
  before do
    @item1 = Item.create!(name: "Item 1", price: 1000, description: "The first item", inventory:10)
    @item2 = Item.create!(name: "Item 2", price: 2000, description: "The second item", inventory:20)

    @item1_shipment_outgoing_1 = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: true, created_at: Date.parse("2022-01-08"), updated_at: Date.parse("2022-01-09"))
    @i1_outgoing_1_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @item1_shipment_outgoing_1.id, quantity: 1)

    @item1_shipment_outgoing_2 = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: true, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-01"))
    @i1_outgoing_2_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @item1_shipment_outgoing_2.id, quantity: 1)

    @item1_shipment_incoming_1 = Shipment.create!(origin: "123 Fake St", destination: "123 Real Corp Street", outgoing: false, arrived: false, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))
    @i1_incoming_1_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @item1_shipment_incoming_1.id, quantity: 1)

    @item1_shipment_incoming_2 = Shipment.create!(origin: "123 Fake St", destination: "123 Real Corp Street", outgoing: false, arrived: true, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-01"))
    @i1_incoming_2_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @item1_shipment_incoming_2.id, quantity: 1)

    @item2_shipment_outgoing = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: true, created_at: Date.parse("2022-11-01"), updated_at: Date.parse("2022-12-01"))
    @i2_outgoing_shipment_item = ShipmentItem.create!(item_id: @item2.id, shipment_id: @item2_shipment_outgoing.id, quantity: 1)

    @both_items_shipment = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: true, created_at: Date.parse("2021-11-01"), updated_at: Date.parse("2021-12-01"))
    @i1_outgoing_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @both_items_shipment.id, quantity: 1)
    @i2_outgoing_shipment_item = ShipmentItem.create!(item_id: @item2.id, shipment_id: @both_items_shipment.id, quantity: 1)



    visit "/items/#{@item1.id}"
  end

  it "displays the item's info" do
    expect(page).to have_content("Item 1")
    expect(page).to have_content("Price: $10.00")
    expect(page).to have_content("Inventory: 10")
    expect(page).to have_content("Description: The first item")

    expect(page).not_to have_content("Item 2")
    expect(page).not_to have_content("Price: $20.00")
    expect(page).not_to have_content("Inventory: 20")
    expect(page).not_to have_content("Description: The second item")
  end

  it "displays the latest shipment dates for this item" do
    within("#latest-incoming") do
      expect(page).to have_content("Latest incoming shipment: 01/01/2022")

      expect(page).not_to have_content("Latest incoming shipment: 01/08/2022")
    end

    within("#latest-outgoing") do
      expect(page).to have_content("Latest outgoing shipment: 01/08/2022")

      expect(page).not_to have_content("Latest outgoing shipment: 01/01/2022")
    end
  end

  it "displays list of shipments including this item" do
    within("#all-shipments") do
      expect(page).to have_content("Shipment ##{@item1_shipment_outgoing_1.id}")
      expect(page).to have_content("Shipment ##{@item1_shipment_outgoing_2.id}")
      expect(page).to have_content("Shipment ##{@item1_shipment_incoming_1.id}")
      expect(page).to have_content("Shipment ##{@item1_shipment_incoming_2.id}")
      expect(page).to have_content("Shipment ##{@both_items_shipment.id}")

      expect(page).not_to have_content("Shipment ##{@item2_shipment_outgoing.id}")
    end
  end

  it "displays shipments in order by updated_at" do
    expect("Shipment ##{@item1_shipment_outgoing_1.id}").to appear_before("Shipment ##{@item1_shipment_incoming_1.id}")
    expect("Shipment ##{@item1_shipment_incoming_1.id}").to appear_before("Shipment ##{@item1_shipment_incoming_2.id}")
  end

  it "displays whether shipment is incoming or outging" do
    within("#shipment-#{@item1_shipment_outgoing_1.id}") do
      expect(page).to have_content("Outgoing")

      expect(page).not_to have_content("Incoming")
    end

    within("#shipment-#{@item1_shipment_incoming_1.id}") do
      expect(page).to have_content("Incoming")

      expect(page).not_to have_content("Outgoing")
    end
  end

  it "includes links to shipment show pages" do
    within("#shipment-#{@item1_shipment_outgoing_1.id}") do
      click_link("Shipment ##{@item1_shipment_outgoing_1.id}")

      expect(current_path).to eq("/shipments/#{@item1_shipment_outgoing_1.id}")
    end
  end

  it "Has a button to edit the item" do
    click_button("Edit this item")

    expect(current_path).to eq("/items/#{@item1.id}/edit")
  end

  it "Has a button to delete the item" do
    click_button("Delete this item")

    expect(current_path).to eq("/items")

    expect(page).not_to have_content("Item 1")
  end

  context "navigation" do
    it "has links to home page, item index, and shipment index" do
      expect(page).to have_link("Go to home page")
      expect(page).to have_link("Go to item index")
      expect(page).to have_link("Go to shipment index")
    end
  end
end
