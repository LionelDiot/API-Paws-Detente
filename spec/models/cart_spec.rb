require 'rails_helper'

RSpec.describe Cart, type: :model do
  before(:each) do 
    # en général, tu as envie de créer une nouvelle instance
    @cart = FactoryBot.create(:cart)  
    end
  
    context "validations" do
      it "has a valid factory" do
        # teste toujours tes factories pour voir si elles sont valides
        expect(build(:cart)).to be_valid
      end

      it "is valid with valid attributes" do
        expect(@cart).to be_a(Cart)
      end

      describe "#some_attribute" do
        # teste cet attribut, en fonction de la validation que tu lui as donnée
      end
  
    end
  
    context "associations" do
  
      it { expect(FactoryBot.create(:cart)).to have_many(:line_items) }
      it { expect(FactoryBot.create(:cart)).to belong_to(:user) }
    end
  
    context "callbacks" do
  
      describe "some callbacks" do
        # teste ce callback
      end
  
    end
  
    context "public instance methods" do
  
      describe "#cart_total" do
        it "calculates the total price of the cart" do
          cart = FactoryBot.create(:cart) # Create a cart instance using FactoryBot
    
          # Create line items associated with the cart
          line_item1 = FactoryBot.create(:line_item, cart: cart, line_item_price: 10)
          line_item2 = FactoryBot.create(:line_item, cart: cart, line_item_price: 20)
    
          # Calculate the expected total price
          expected_total = line_item1.line_item_price + line_item2.line_item_price
    
          expect(cart.cart_total).to eq(expected_total)
        end
      end
    
      describe "#add_line_item" do
        it "adds a new line item to the cart" do
          cart = FactoryBot.create(:cart) # Create a cart instance using FactoryBot
          item = FactoryBot.create(:item) # Create an item instance using FactoryBot
    
          line_item = cart.add_line_item(item, 2)
    
          expect(line_item).to be_an_instance_of(LineItem)
          expect(line_item.cart).to eq(cart)
          expect(line_item.item).to eq(item)
          expect(line_item.quantity).to eq(2)
        end
      end
    
      describe "#edit_line_item" do
        it "edits the quantity of an existing line item in the cart" do
          cart = FactoryBot.create(:cart) # Create a cart instance using FactoryBot
          item = FactoryBot.create(:item) # Create an item instance using FactoryBot
          line_item = FactoryBot.create(:line_item, cart: cart, item: item, quantity: 2)
    
          updated_line_item = cart.edit_line_item(item, 5)
    
          expect(updated_line_item).to eq(line_item)
          expect(updated_line_item.quantity).to eq(5)
        end
      end
    
      describe "#delete_line_item" do
        it "deletes an existing line item from the cart" do
          cart = FactoryBot.create(:cart) # Create a cart instance using FactoryBot
          item = FactoryBot.create(:item) # Create an item instance using FactoryBot
          line_item = FactoryBot.create(:line_item, cart: cart, item: item)
    
          cart.delete_line_item(item)
    
          expect(LineItem.exists?(line_item.id)).to be false
        end
      end
    
      describe "#empty_cart" do
        it "deletes all line items from the cart" do
          cart = FactoryBot.create(:cart) # Create a cart instance using FactoryBot
          FactoryBot.create_list(:line_item, 3, cart: cart) # Create multiple line items associated with the cart
    
          cart.empty_cart
    
          expect(cart.line_items.count).to eq(0)
        end
      end
  
    end
  
  
end
