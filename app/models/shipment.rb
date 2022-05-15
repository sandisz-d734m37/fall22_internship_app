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

  def arrival_status
    if arrived
      "Arrived"
    else
      "Still en route"
    end
  end

  def self.all_outgoing
    where("outgoing = ?", true)
  end

  def self.all_incoming
    where("outgoing = ?", false)
  end
end
