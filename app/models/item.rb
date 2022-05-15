class Item < ApplicationRecord
  has_many :shipment_items
  has_many :shipments, through: :shipment_items


  def helper
    ActionController::Base.helpers
  end

  def formatted_price
    price_to_convert = price / 100.0
    helper.number_to_currency(price_to_convert)
  end

  def self.alphabetize
    all.order(:name)
  end
end
