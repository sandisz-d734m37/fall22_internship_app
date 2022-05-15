class Item < ApplicationRecord
  has_many :shipment_items
  has_many :shipments, through: :shipment_items

  validates_presence_of :name

  def helper
    ActionController::Base.helpers
  end

  def formatted_price
    price_to_convert = price / 100.0
    helper.number_to_currency(price_to_convert)
  end

  def latest_incoming_date
    date = shipments
    .where("arrived = ? AND outgoing = ?", true, false)
    .order(updated_at: :desc)
    .first

    date.updated_at.strftime("%m/%d/%Y") unless date.nil?
  end

  def latest_outgoing_date
    date = shipments
    .where("outgoing = ?", true)
    .order(created_at: :desc)
    .first

    date.created_at.strftime("%m/%d/%Y") unless date.nil?
  end

  def ordered_shipments
    shipments
    .order(updated_at: :desc)
  end

  def shipment_item_for(shipment)
    shipment_items
    .where("shipment_id = ?", shipment.id)
    .first
  end

  def total_in_shipment(shipment)
    shipment_item = shipment_item_for(shipment)

    total = (shipment_item.quantity * price).to_f / 100
    helper.number_to_currency(total)
  end

  def self.alphabetize
    all.order(:name)
  end
end
