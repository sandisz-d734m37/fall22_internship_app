require "rails_helper"

describe Shipment do
  describe "relationships" do
    it{should have_many(:shipment_items)}
    it{should have_many(:items).through(:shipment_items)}
  end

  describe "vlaidations" do
    it{should validate_presence_of(:origin)}
    it{should validate_presence_of(:destination)}
  end

  before do
    @incoming_shipment = Shipment.create!(origin: "123 Fake St", destination: "123 Real Corp Street", outgoing: false, arrived: false, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))
    @incoming_shipment_2 = Shipment.create!(origin: "123 Fake St", destination: "123 Real Corp Street", outgoing: false, arrived: false, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))
    @outgoing_shipment = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: true, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))
    @outgoing_shipment_2 = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: false, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))

    @item1 = Item.create!(name: "Item 1", price: 1000, description: "The first item", inventory:10)
    @item2 = Item.create!(name: "Item 2", price: 2000, description: "The second item", inventory:20)
    @item3 = Item.create!(name: "Item 3", price: 3000, description: "The third item", inventory:30)

    @in_ship_2_item1 = ShipmentItem.create!(item_id: @item1.id, shipment_id: @incoming_shipment_2.id, quantity: 3)
    @in_ship_2_item2 = ShipmentItem.create!(item_id: @item2.id, shipment_id: @incoming_shipment_2.id, quantity: 3)
    @in_ship_2_item3 = ShipmentItem.create!(item_id: @item3.id, shipment_id: @incoming_shipment_2.id, quantity: 4)
  end

  describe "instance methods" do
    context "#in_or_out" do
      it "determines whether shipment is incoming or outgoing" do
        expect(@incoming_shipment.in_or_out).to eq("Incoming")
        expect(@outgoing_shipment.in_or_out).to eq("Outgoing")
      end
    end

    context "#arrival_status" do
      it "returns arrival status based on arrival boolean" do
        expect(@outgoing_shipment.arrival_status).to eq("Arrived")
        expect(@incoming_shipment.arrival_status).to eq("Still en route")
      end
    end

    context "#format_created_date" do
      it "returns formatted date" do
        expect(@outgoing_shipment.format_created_date).to eq("01/01/2022")
      end
    end

    context "#format_updated_date" do
      it "returns formatted date" do
        expect(@outgoing_shipment.format_updated_date).to eq("01/08/2022")
      end
    end

    context "#item_count" do
      it "returns total num of items in shipment" do
        expect(@incoming_shipment_2.item_count).to eq(10)
        expect(@incoming_shipment.item_count).to eq(0)
      end
    end

    context "#total" do
      it "returns total cost of items in shipment" do
        expect(@incoming_shipment_2.total).to eq("$210.00")
        expect(@incoming_shipment.total).to eq("$0.00")
      end
    end
  end

  describe "class methods" do
    context "#all_outgoing" do
      it "finds all outgoing shipments" do
        expect(Shipment.all_outgoing).to eq([@outgoing_shipment, @outgoing_shipment_2])

        expect(Shipment.all_outgoing).not_to include(@incoming_shipment)
      end
    end

    context "#all_incoming" do
      it "finds all incoming shipments" do
        expect(Shipment.all_incoming).to eq([@incoming_shipment, @incoming_shipment_2])

        expect(Shipment.all_incoming).not_to include(@outgoing_shipment)
      end
    end
  end
end
