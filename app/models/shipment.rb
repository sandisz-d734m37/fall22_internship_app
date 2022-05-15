require 'helpable'

class Shipment < ApplicationRecord
  has_many :shipment_items
  has_many :items, through: :shipment_items

  include Helpable

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

  def format_created_date
    created_at.strftime("%m/%d/%Y")
  end

  def format_updated_date
    updated_at.strftime("%m/%d/%Y")
  end

  def item_count
    counts = shipment_items.map { |item| item.quantity }
    counts.sum
  end

  def total
    prices = items.map { |item| item.total_in_shipment(self)[1..-1].to_f}

    helper.number_to_currency(prices.sum)
  end
end
