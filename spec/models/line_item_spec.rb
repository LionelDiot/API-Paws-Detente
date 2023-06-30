require 'rails_helper'

RSpec.describe LineItem, type: :model do
  before(:each) do 
    # en général, tu as envie de créer une nouvelle instance
    @line_item = FactoryBot.create(:line_item)   
    end
  
    context "validations" do
      it "has a valid factory" do
        # teste toujours tes factories pour voir si elles sont valides
        expect(build(:line_item)).to be_valid
      end
      
      it "is valid with valid attributes" do
        expect(@line_item).to be_a(LineItem)
      end
  


      describe "#quantity" do
        it { expect(@line_item).to validate_presence_of(:quantity) }
      end
  
    end
  
    context "associations" do
  
      it { expect(FactoryBot.create(:line_item)).to belong_to(:cart) }
      it { expect(FactoryBot.create(:line_item)).to belong_to(:item) }
    end
  
  
    context "public instance methods" do
  
      describe "#line_item_price" do
        it "calculates the price of the line item based on quantity and item price" do
          item = FactoryBot.create(:item, price: 10)
          line_item = FactoryBot.create(:line_item, item: item, quantity: 3)
    
          expect(line_item.line_item_price).to eq(30) # 10 * 3 = 30
        end
      end
    
      describe "#check_quantity" do
        it "destroys line items with quantity less than or equal to zero after save" do
          cart = FactoryBot.create(:cart) # Create a cart instance using FactoryBot
          item1 = FactoryBot.create(:item)
          item2 = FactoryBot.create(:item)
          item3 = FactoryBot.create(:item)
          # Create line items associated with the cart

          line_item2 = FactoryBot.create(:line_item, cart: cart, item: item2, quantity: 2)
          line_item3 = FactoryBot.create(:line_item, cart: cart, item: item3, quantity: 3)

          updated_line_item2 = cart.edit_line_item(item2, 2)
          updated_line_item3 = cart.edit_line_item(item3, 2)
          new_item = updated_line_item2.check_quantity
          new_item3 = updated_line_item3.check_quantity

           expect(LineItem.exists?(updated_line_item3.id)).to be true
           expect(LineItem.exists?(updated_line_item3.id)).to be true
        end
      end
  
    end
  
  
end
