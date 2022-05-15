require 'rails_helper'

describe "Shipment index page" do
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
    @i1_both_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @both_items_shipment.id, quantity: 1)
    @i2_both_shipment_item = ShipmentItem.create!(item_id: @item2.id, shipment_id: @both_items_shipment.id, quantity: 1)



    visit "/shipments"
  end

  it "has an incoming and outgoing section to list all shipments" do
    within("#incoming") do
      expect(page).to have_content("Shipment ##{@item1_shipment_incoming_1.id}")
      expect(page).to have_content("Shipment ##{@item1_shipment_incoming_2.id}")

      expect(page).not_to have_content("Shipment ##{@item1_shipment_outgoing_1.id}")
      expect(page).not_to have_content("Shipment ##{@item1_shipment_outgoing_2.id}")
      expect(page).not_to have_content("Shipment ##{@item2_shipment_outgoing.id}")
      expect(page).not_to have_content("Shipment ##{@both_items_shipment.id}")
    end

    within("#outgoing") do
      expect(page).to have_content("Shipment ##{@item1_shipment_outgoing_1.id}")
      expect(page).to have_content("Shipment ##{@item1_shipment_outgoing_2.id}")
      expect(page).to have_content("Shipment ##{@item2_shipment_outgoing.id}")
      expect(page).to have_content("Shipment ##{@both_items_shipment.id}")

      expect(page).not_to have_content("Shipment ##{@item1_shipment_incoming_1.id}")
      expect(page).not_to have_content("Shipment ##{@item1_shipment_incoming_2.id}")
    end
  end

  it "links to shipment show pages" do
    within("#shipment-#{@item1_shipment_outgoing_1.id}") do
      click_link "Shipment ##{@item1_shipment_outgoing_1.id}"

      expect(current_path).to eq("/shipments/#{@item1_shipment_outgoing_1.id}")
    end
  end

  it "shows shipment status" do
    within("#shipment-#{@item1_shipment_outgoing_1.id}") do
      expect(page).to have_content("Arrived")

      expect(page).not_to have_content("Still en route")
    end

    within("#shipment-#{@item1_shipment_incoming_1.id}") do
      expect(page).to have_content("Still en route")

      expect(page).not_to have_content("Arrived")
    end
  end
end
