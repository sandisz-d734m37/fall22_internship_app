require "rails_helper"

describe Item do
  describe "relationships" do
    it{should have_many(:shipment_items)}
    it{should have_many(:shipments).through(:shipment_items)}
  end

  describe "validations" do
    it{should validate_presence_of(:name)}
  end

  before do
    @item1 = Item.create!(name: "B Item 1", price: 1000, description: "The first item", inventory:10)
    @item2 = Item.create!(name: "C Item 2", price: 2050, description: "The second item", inventory:20)
    @item3 = Item.create!(name: "A Item 3", price: 3000, description: "The second item", inventory:20)

    @item1_shipment_incoming_1 = Shipment.create!(origin: "123 Fake St", destination: "123 Real Corp Street", outgoing: false, arrived: false, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))
    @i1_incoming_1_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @item1_shipment_incoming_1.id, quantity: 1)

    @item1_shipment_incoming_2 = Shipment.create!(origin: "123 Fake St", destination: "123 Real Corp Street", outgoing: false, arrived: true, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-01"))
    @i1_incoming_2_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @item1_shipment_incoming_2.id, quantity: 1)

    @item1_shipment_outgoing_1 = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: true, created_at: Date.parse("2022-01-08"), updated_at: Date.parse("2022-01-09"))
    @i1_outgoing_1_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @item1_shipment_outgoing_1.id, quantity: 1)

    @item1_shipment_outgoing_2 = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: true, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-10"))
    @i1_outgoing_2_shipment_item = ShipmentItem.create!(item_id: @item1.id, shipment_id: @item1_shipment_outgoing_2.id, quantity: 1)
  end

  describe "instance methods" do
    context "#formatted_price" do
      it "formats item prices to include all zeroes" do

        expect(@item1.formatted_price).to eq("$10.00")
        expect(@item2.formatted_price).to eq("$20.50")
      end
    end

    context "#latest_incoming_date" do
      it "finds the items latest incoming shipment that has arrived" do
        expect(@item1.latest_incoming_date).to eq("01/01/2022")

        expect(@item1.latest_incoming_date).not_to eq("01/08/2022")
      end
    end

    context "#latest_outgoing_date" do
      it "finds the items latest outging shipment based on creation date (not updated date)" do
        expect(@item1.latest_outgoing_date).to eq("01/08/2022")

        expect(@item1.latest_outgoing_date).not_to eq("01/09/2022")
        expect(@item1.latest_outgoing_date).not_to eq("01/10/2022")
      end
    end

    context "#ordered_shipments" do
      it "sorts all item shipments by updated_at" do
        expect(@item1.ordered_shipments).to eq([@item1_shipment_outgoing_2, @item1_shipment_outgoing_1, @item1_shipment_incoming_1, @item1_shipment_incoming_2])
      end
    end
  end

  describe "Class methods" do
    context "#alphabetize" do
      it "alphabetizes all the items" do
        expect(Item.alphabetize).to eq([@item3, @item1, @item2])
      end
    end
  end
end
