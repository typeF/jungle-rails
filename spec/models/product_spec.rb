require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'A new category should be present' do
      @category = Category.create(name: "Toys")
      @id = @category.id
      @product = Product.create(name: "Tickle me Elmo", category_id: @id, price_cents: 900, quantity: 20)
      expect(@product.id).to be_present
    end

    it 'Should not be valid if name is mising' do
      @category = Category.create(name: "Toys")
      @id = @category.id
      @product = Product.create(name: nil, category_id: @id, price_cents: 900, quantity: 20)
      expect(@product.errors.full_messages).to be_present
    end

    it 'Should not be valid if price is mising' do
      @category = Category.create(name: "Toys")
      @id = @category.id
      @product = Product.create(name: nil, category_id: @id, price_cents: nil, quantity: 20)
      expect(@product.errors.full_messages).to be_present
    end

    it 'Should not be valid if quantity is mising' do
      @category = Category.create(name: "Toys")
      @id = @category.id
      @product = Product.create(name: nil, category_id: @id, price_cents: 900, quantity: nil)
      expect(@product.errors.full_messages).to be_present
    end

    it 'Should not be valid if category is mising' do
      @category = Category.create(name: "Toys")
      @id = @category.id
      @product = Product.create(name: nil, category_id: nil, price_cents: 900, quantity: 20)
      expect(@product.errors.full_messages).to be_present
    end

  end
end
