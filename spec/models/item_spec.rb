require "rails_helper"

describe Item do
  describe "relationships" do
    it{should have_many(:shipment_items)}
    it{should have_many(:shipments).through(:shipment_items)}
  end

  before do
    @item1 = Item.create!(name: "B Item 1", price: 1000, description: "The first item", inventory:10)
    @item2 = Item.create!(name: "C Item 2", price: 2050, description: "The second item", inventory:20)
    @item3 = Item.create!(name: "A Item 3", price: 3000, description: "The second item", inventory:20)
  end

  describe "instance methods" do
    context "#formatted_price" do
      it "formats item prices to include all zeroes" do

        expect(@item1.formatted_price).to eq("$10.00")
        expect(@item2.formatted_price).to eq("$20.50")
      end
    end
  end

  describe "Class methods" do
    context "#alphabetize" do
      it "alphabetizes all the items" do
        expect(Item.aplhabetize).to eq([@item3, @item1, @item2])
      end
    end
  end
end
