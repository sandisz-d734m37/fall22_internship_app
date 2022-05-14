require "rails_helper"

describe Item do
  describe "relationships" do
    it{should have_many(:shipment_items)}
    it{should have_many(:shipments).through(:shipment_items)}
  end

  describe "instance methods" do
    context "#formatted_price" do
      it "formats item prices to include all zeroes" do
        item1 = Item.create!(name: "B Item 1", price: 1000, description: "The first item", inventory:10)
        item2 = Item.create!(name: "C Item 2", price: 2050, description: "The second item", inventory:20)

        expect(item1.formatted_price).to eq("$10.00")
        expect(item2.formatted_price).to eq("$20.50")
      end
    end
  end
end
