class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :adjust_product_qty

  private

  def adjust_product_qty
    line_items.each do |line_item|
      quantity = line_item.quantity
      line_item.product.quantity -= quantity
      line_item.product.save
    end
  end

end
