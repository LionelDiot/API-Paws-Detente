require 'rails_helper'

RSpec.describe Order, type: :model do
  before(:each) do 
    # en général, tu as envie de créer une nouvelle instance
    @order = FactoryBot.create(:order)   
    end
  
    context "validations" do
      it "has a valid factory" do
        # teste toujours tes factories pour voir si elles sont valides
        expect(build(:order)).to be_valid
      end
      
      it "is valid with valid attributes" do
        expect(@order).to be_a(Order)
      end
  

      describe "#total" do
        it { expect(@order).to validate_presence_of(:total) }
      end
  
    end
  
    context "associations" do
  
      describe "some association" do
        # teste cette association
      end
  
    end
  
    context "callbacks" do
  
      describe "some callbacks" do
        it { expect(FactoryBot.create(:order)).to belong_to(:user) }
        it { expect(FactoryBot.create(:order)).to have_many(:order_items) }
      end
  
    end
  

  
    context "public class methods" do
  
      describe "self.some_method" do
        # teste cette méthode
      end
      
    end
    
end
