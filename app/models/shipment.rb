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

  def self.all_outgoing
    where("outgoing = ?", true)
  end
end
