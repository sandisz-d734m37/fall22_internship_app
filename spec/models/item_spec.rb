require "rails_helper"

describe Item do
  context "validations" do
    it{should have_many(:shipment_items)}
    it{should have_many(:shipments).through(:shipment_items)}
  end
end
