require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before do
      @category = Category.new(:name => "Toys")
      @name = "New Product"
      @price = 20
      @quantity = 3
    end

    it "accepts product with all four fields" do
      @product = Product.new(:name => @name, :price_cents => @price, :quantity => @quantity, :category => @category )
      
      expect(@product).to be_valid
      expect(@product.errors.full_messages.empty?).to be_truthy
    end

    it "does not save nil in name field" do
      @product = Product.new(:name => nil, :price_cents => @price, :quantity => @quantity, :category => @category )
      
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not save nil in price field" do
      @product = Product.new(:name => @name, :price_cents => nil, :quantity => @quantity, :category => @category )
      
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not save nil in quantity field" do
      @product = Product.new(:name => @name, :price_cents => @price, :quantity => nil, :category => @category )
      
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not save nil in category field" do
      @product = Product.new(:name => @name, :price_cents => @price, :quantity => @quantity, :category => nil )
      
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.empty?).to_not be_truthy
    end
  end
end