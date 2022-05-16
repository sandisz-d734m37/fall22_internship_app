require "rails_helper"

describe "new shipment page" do
  before do
    @item1 = Item.create!(name: "Item 1", price: 1000, description: "The first item", inventory:10)
    @item2 = Item.create!(name: "Item 2", price: 2000, description: "The second item", inventory:20)

    @item1_outgoing_shipment = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: false, created_at: Date.parse("2022-01-08"), updated_at: Date.parse("2022-01-09"))
    @outgoing_shipment_item1 = ShipmentItem.create!(item_id: @item1.id, shipment_id: @item1_outgoing_shipment.id, quantity: 1)

    @item1.update_for_shipment(@item1_outgoing_shipment)
    visit "/shipments/#{@item1_outgoing_shipment.id}"
  end

  it "has a form to update shipment arrival status" do
    expect(page).to have_content("Still en route")
    expect(page).not_to have_content("Arrived")

    click_button("Edit shipment")
    expect(current_path).to eq("/shipments/#{@item1_outgoing_shipment.id}/edit")

    page.check('Arrived')

    click_button("Update shipment")

    expect(current_path).to eq("/shipments/#{@item1_outgoing_shipment.id}")
    expect(page).to have_content("Arrived")
    expect(page).not_to have_content("Still en route")
  end

  it "still redirects to show and does nothing when checkbox is not selected" do
    expect(page).to have_content("Still en route")
    expect(page).not_to have_content("Arrived")

    click_button("Edit shipment")
    expect(current_path).to eq("/shipments/#{@item1_outgoing_shipment.id}/edit")

    click_button("Update shipment")

    expect(current_path).to eq("/shipments/#{@item1_outgoing_shipment.id}")
    expect(page).to have_content("Still en route")
    expect(page).not_to have_content("Arrived")
  end

end
