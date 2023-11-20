require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    it 'should not save a product without a name' do
      @product = Product.new(name: nil, price_cents: 100, quantity: 1, category: Category.new(name: 'TESTPLANTS'))
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save a product without a price' do
      @product = Product.new(name: 'the longest monsterra', price_cents: nil, quantity: 1, category: Category.new(name: 'TESTPLANTS'))
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not save a product without a quantity' do
      @product = Product.new(name: 'the longest monsterra', price_cents: 100, quantity: nil, category: Category.new(name: 'TESTPLANTS'))
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save a product without a category' do
      @product = Product.new(name: 'the longest monsterra', price_cents: 100, quantity: 1, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
    
    it 'should save a product with all four fields set' do
      @product = Product.new(name: 'the longest monsterra', price_cents: 100, quantity: 1, category: Category.new(name: 'TESTPLANTS'))
      expect(@product).to be_valid
    end
  end
end
