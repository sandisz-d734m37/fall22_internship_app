require "rails_helper"

describe Shipment do
  describe "relationships" do
    it{should have_many(:shipment_items)}
    it{should have_many(:items).through(:shipment_items)}
  end

  before do
    @incoming_shipment = Shipment.create!(origin: "123 Fake St", destination: "123 Real Corp Street", outgoing: false, arrived: false, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))
    @incoming_shipment_2 = Shipment.create!(origin: "123 Fake St", destination: "123 Real Corp Street", outgoing: false, arrived: false, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))
    @outgoing_shipment = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: true, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))
    @outgoing_shipment_2 = Shipment.create!(origin: "123 Real Corp Street", destination: "123 Fake St", outgoing: true, arrived: false, created_at: Date.parse("2022-01-01"), updated_at: Date.parse("2022-01-08"))
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
