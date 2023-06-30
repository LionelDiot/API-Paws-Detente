require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before(:each) do 
    # en général, tu as envie de créer une nouvelle instance
    @order_item = FactoryBot.create(:order_item)   
    end
  
    context "validations" do
      it "has a valid factory" do
        # teste toujours tes factories pour voir si elles sont valides
        expect(build(:order_item)).to be_valid
      end
      
      it "is valid with valid attributes" do
        expect(@order_item).to be_a(OrderItem)
      end
  
      describe "#item_title" do
        it { expect(@order_item).to validate_presence_of(:item_title) }
      end

      describe "#item_price" do
        it { expect(@order_item).to validate_presence_of(:item_price) }
      end

      describe "#line_item_price" do
        it { expect(@order_item).to validate_presence_of(:line_item_price) }
      end

      describe "#quantity" do
        it { expect(@order_item).to validate_presence_of(:quantity) }
      end

  
    end
  
    context "associations" do
  
      describe "some association" do
        # teste cette association
      end
  
    end
  
    context "callbacks" do
  
      describe "some callbacks" do
        # teste ce callback
      end
  
    end
  
    context "public instance methods" do
  
      describe "#some_method" do
        # teste cette méthode
      end
  
    end
  
    context "public class methods" do
  
      describe "self.some_method" do
        # teste cette méthode
      end
  
    end
  
end
