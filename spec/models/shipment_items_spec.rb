require "rails_helper"

describe ShipmentItem do
  context "relationships" do
    it{should belong_to(:item)}
    it{should belong_to(:shipment)}
  end
end
