require "rails_helper"

describe Shipment do
  context "relationships" do
    it{should have_many(:shipment_items)}
    it{should have_many(:items).through(:shipment_items)}
  end
end
