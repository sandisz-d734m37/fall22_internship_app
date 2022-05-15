class Shipment < ApplicationRecord
  has_many :shipment_items
  has_many :items, through: :shipment_items

  def in_or_out
    if outgoing
      "Outgoing"
    else
      "Incoming"
    end
  end
end
