require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category = Category.create!(name: "Toys")
      @id = @category.id
      @product1 = Product.create!(name: "Tickle me Elmo", category_id: @id, price_cents: 500, quantity: 5000)
      @product2 = Product.create!(name: "GI Joe", category_id: @id, price_cents: 20, quantity: 20)
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create!(name: "Barbie", category_id: @id, price_cents: 90, quantity: 90)
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(email: "test@test.com", total_cents: 999, stripe_charge_id: 10)
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 2,
        item_price: @product1.price,
        total_price: @product1.price * 20
      )
      @order.line_items.new(
        product: @product2,
        quantity: 10,
        item_price: @product1.price,
        total_price: @product1.price * 20
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eql(4998)
      expect(@product2.quantity).to eql(10)
    end
    it 'does not deduct quantity from products that are not in the order' do
      expect(@product3.quantity).to eql(90)
    end
  end
end