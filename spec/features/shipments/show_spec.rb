require "rails_helper"

describe "Shipment show page" do
  before do
    @item1 = Item.create!(name: "Item 1", price: 1000, description: "The first item", inventory:10)
    @item2 = Item.create!(name: "Item 2", price: 2000, description: "The second item", inventory:20)
    @item3 = Item.create!(name: "Item 3", price: 3000, description: "The third item", inventory:30)

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
    @i1_outgoing_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @both_items_shipment.id, quantity: 3)
    @i2_outgoing_shipment_item = ShipmentItem.create!(item_id: @item2.id, shipment_id: @both_items_shipment.id, quantity: 1)



    visit "/shipments/#{@both_items_shipment.id}"
  end

  it "displays shipment information" do
    expect(page).to have_content("Shipment ##{@both_items_shipment.id}")
    expect(page).to have_content("Destination: 123 Fake St")
    expect(page).to have_content("Origin: 123 Real Corp Street")
    expect(page).to have_content("Outgoing")
    expect(page).to have_content("Arrived")
    expect(page).to have_content("Created: 11/01/2021")
    expect(page).to have_content("Last updated: 12/01/2021")

    expect(page).not_to have_content("Incoming")
    expect(page).not_to have_content("Still en route")
  end

  it "displays item information" do
    within("#items") do
      expect(page).to have_link("Item 1")
      expect(page).to have_link("Item 2")

      expect(page).not_to have_link("Item 3")
    end

    within("#item-#{@item1.id}") do
      expect(page).to have_content("Quantity: 3")
      expect(page).to have_content("Unit Price: $10.00")
      expect(page).to have_content("Total Item Price: $30.00")
    end

    within("#item-#{@item2.id}") do
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Unit Price: $20.00")
      expect(page).to have_content("Total Item Price: $20.00")
    end
  end

  it "displays the total number and cost of all items in the shipment" do
    within("#totals") do
      expect(page).to have_content("Total items: 4")
      expect(page).to have_content("Total cost: $50.00")
    end
  end

  context "navigation" do
    it "has links to home page, item index, and shipment index" do
      expect(page).to have_link("Go to home page")
      expect(page).to have_link("Go to item index")
      expect(page).to have_link("Go to shipment index")
    end
  end
end
