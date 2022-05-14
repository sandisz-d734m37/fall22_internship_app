require "rails_helper"

describe ShipmentItem do
  context "validations" do
    it{should have_many(:items)}
    it{should have_many(:shipments)}
  end
end
